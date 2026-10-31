const express = require('express');
const cors = require('cors');
require('dotenv').config();
const { initDB, getDB } = require('./data/database');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Middleware: Soporta idioma por Query Param (?lang=quc) O por Header (accept-language)
app.use((req, res, next) => {
  const queryLang = req.query.lang;
  const headerLang = req.headers['accept-language'];
  const lang = queryLang || headerLang || 'es';
  
  req.lang = ['es', 'quc'].includes(lang) ? lang : 'es';
  next();
});

// Helper seguro para parsear JSON
const safeJsonParse = (str) => {
  try {
    return JSON.parse(str || '[]');
  } catch (e) {
    return [];
  }
};

// 1. INSTITUCIONES
app.get('/api/instituciones', async (req, res) => {
  try {
    const db = getDB();
    const lang = req.lang;
    const rows = await db.all('SELECT * FROM instituciones');

    const result = rows.map(i => ({
      id: i.id,
      codigo: i.codigo,
      nombre: i.nombre,
      descripcion: (lang === 'quc' && i.descripcion_quc) ? i.descripcion_quc : i.descripcion_es
    }));

    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 2. TRÁMITES (FILTRADO POR INSTITUCIÓN)
app.get('/api/tramites', async (req, res) => {
  try {
    const db = getDB();
    const lang = req.lang;
    const { institucion_codigo } = req.query;

    let query = 'SELECT * FROM tramites';
    let params = [];

    if (institucion_codigo) {
      query += ' WHERE LOWER(institucion_codigo) = LOWER(?)';
      params.push(institucion_codigo);
    }

    const rows = await db.all(query, params);

    const result = rows.map(t => ({
      id: t.id,
      institucion: t.institucion_codigo,
      categoria: t.categoria,
      titulo: (lang === 'quc' && t.titulo_quc) ? t.titulo_quc : t.titulo_es,
      requisitos: safeJsonParse(lang === 'quc' && t.requisitos_quc ? t.requisitos_quc : t.requisitos_es),
      documentos: safeJsonParse(lang === 'quc' && t.documentos_quc ? t.documentos_quc : t.documentos_es),
      contacto_telefono: t.contacto_telefono,
      contacto_web: t.contacto_web
    }));

    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 3. TRÁMITE POR ID (OBTENER DETALLE INDIVIDUAL)
app.get('/api/tramites/:id', async (req, res) => {
  try {
    const db = getDB();
    const lang = req.lang;
    const { id } = req.params;

    const t = await db.get('SELECT * FROM tramites WHERE id = ?', [id]);

    if (!t) {
      return res.status(404).json({ error: "Trámite no encontrado" });
    }

    const result = {
      id: t.id,
      institucion: t.institucion_codigo,
      categoria: t.categoria,
      titulo: (lang === 'quc' && t.titulo_quc) ? t.titulo_quc : t.titulo_es,
      requisitos: safeJsonParse(lang === 'quc' && t.requisitos_quc ? t.requisitos_quc : t.requisitos_es),
      documentos: safeJsonParse(lang === 'quc' && t.documentos_quc ? t.documentos_quc : t.documentos_es),
      contacto_telefono: t.contacto_telefono,
      contacto_web: t.contacto_web
    };

    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 4. SEDES
app.get('/api/sedes', async (req, res) => {
  try {
    const db = getDB();
    const { institucion_codigo } = req.query;

    let query = 'SELECT * FROM sedes';
    let params = [];

    if (institucion_codigo) {
      query += ' WHERE LOWER(institucion_codigo) = LOWER(?)';
      params.push(institucion_codigo);
    }

    const rows = await db.all(query, params);
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Inicializar BD y Servidor
initDB().then(() => {
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Servidor InfoG activo con SQLite en http://0.0.0.0:${PORT}`);
    console.log(`Acceso local desde iPhone: http://192.168.0.11:${PORT}`);
  });
});