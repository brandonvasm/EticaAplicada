const sqlite3 = require('sqlite3').verbose();
const { open } = require('sqlite');
const path = require('path');

let db;

async function initDB() {
  db = await open({
    filename: path.join(__dirname, 'infog.db'),
    driver: sqlite3.Database
  });


  await db.exec(`
    CREATE TABLE IF NOT EXISTS instituciones (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      codigo TEXT UNIQUE,
      nombre TEXT,
      descripcion_es TEXT,
      descripcion_quc TEXT
    );
  `);


  await db.exec(`
    CREATE TABLE IF NOT EXISTS tramites (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      institucion_codigo TEXT,
      categoria TEXT,
      titulo_es TEXT,
      titulo_quc TEXT,
      requisitos_es TEXT,
      requisitos_quc TEXT,
      documentos_es TEXT,
      documentos_quc TEXT,
      contacto_telefono TEXT,
      contacto_web TEXT
    );
  `);


  await db.exec(`
    CREATE TABLE IF NOT EXISTS sedes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      institucion_codigo TEXT,
      nombre TEXT,
      direccion TEXT,
      horario TEXT,
      telefono TEXT,
      latitud REAL,
      longitud REAL
    );
  `);




  const countInst = await db.get('SELECT COUNT(*) as total FROM instituciones');
  if (countInst.total === 0) {
    const instituciones = [
      ['CONAMIGUA', 'CONAMIGUA', 'Atención y protección a migrantes guatemaltecos y sus familias', "Tob'anik xukuje' chajinik rech winaq e k'o chajun chik tinamit"],
      ['RENAP', 'RENAP', 'Documentos de identificación personal y registro civil', "Wuj rech q'alajsanik winaqilal"],
      ['IGM', 'IGM', 'Regulación migratoria, pasaportes y control fronterizo', "Q'alajsanik xukuje' chajinik rech okem pa tinamit"],
      ['MSPAS', 'MSPAS', 'Servicios de salud pública y atención médica general', "Patanib'al rech raxnaqil winaqil"],
      ['MINTRAB', 'MINTRAB', 'Empleo, derechos laborales y orientación para retornados', "Chak xukuje' ya'ik utzil rech chakub'al"],
      ['SBS', 'SBS', 'Bienestar social y protección integral a la niñez y adolescencia', "Utzilej k'aslemal xukuje' chajinik rech ak'ala'"]
    ];

    for (const inst of instituciones) {
      await db.run(
        'INSERT INTO instituciones (codigo, nombre, descripcion_es, descripcion_quc) VALUES (?, ?, ?, ?)',
        inst
      );
    }
  }


  const countTram = await db.get('SELECT COUNT(*) as total FROM tramites');
  if (countTram.total === 0) {
    const tramites = [
      // RENAP
      {
        codigo: 'RENAP',
        cat: 'extranjero',
        tit_es: 'Renovación de DPI desde el extranjero',
        tit_quc: "K'ak'arsanik rech DPI chujun chik tinamit",
        req_es: JSON.stringify([
          "1. Cita previa en la sede consular",
          "2. Formulario de solicitud impreso y firmado",
          "3. Pago de tarifa consular (US$ 50.00)"
        ]),
        req_quc: JSON.stringify([
          "1. Nab'ey ch'ab'enik pa consulado",
          "2. Utz'ib'axik wuj tz'akat",
          "3. Wuj rech tojb'al (US$ 50.00)"
        ]),
        doc_es: JSON.stringify([
          "• Pasaporte guatemalteco vigente o vencido",
          "• Certificado de Nacimiento reciente emitido por RENAP",
          "• Comprobante de dirección actual"
        ]),
        doc_quc: JSON.stringify([
          "• Wuj rech pasaporte rech Guatemala",
          "• Wuj rech alaxib'al alaj",
          "• Wuj rech k'olib'al"
        ]),
        tel: '1517',
        web: 'www.renap.gob.gt'
      },
      {
        codigo: 'RENAP',
        cat: 'extranjero',
        tit_es: 'Emisión de Certificado de Nacimiento en línea',
        tit_quc: "Ya'ik Wuj rech Alaxib'al pa k'amasaq",
        req_es: JSON.stringify([
          "1. Crear cuenta en el portal de Servicios Electrónicos e-RENAP",
          "2. Ingresar CUI (Número de DPI) de la persona solicitante",
          "3. Pago electrónico con tarjeta de crédito/débito (Q 15.00)"
        ]),
        req_quc: JSON.stringify([
          "1. Tz'ib'anik pa k'amasaq e-RENAP",
          "2. Okisaxik CUI rech winaq",
          "3. Tojb'al pa k'amasaq (Q 15.00)"
        ]),
        doc_es: JSON.stringify([
          "• Número de CUI / DPI",
          "• Correo electrónico para recepción de documento digital"
        ]),
        doc_quc: JSON.stringify([
          "• Ajilabal CUI / DPI",
          "• K'amasaq correo"
        ]),
        tel: '1517',
        web: 'e.renap.gob.gt'
      },


      {
        codigo: 'CONAMIGUA',
        cat: 'retornado',
        tit_es: 'Recepción y orientación inicial al retornado',
        tit_quc: "K'amowik xukuje' tob'anik rech winaq e tzalajinaq",
        req_es: JSON.stringify([
          "1. Presentarse en el Centro de Recepción de Retornados",
          "2. Registro de datos personales para caracterización",
          "3. Solicitud de pasaje o apoyo para transporte terrestre"
        ]),
        req_quc: JSON.stringify([
          "1. Tz'ib'anik pa k'ulb'il rech xaqan",
          "2. K'otow chi'aj rech tob'anik",
          "3. Ya'ik b'inik o wa'im"
        ]),
        doc_es: JSON.stringify([
          "• Constancia de retorno emitida por autoridades migratorias",
          "• DPI o documento temporal emitido al arribo"
        ]),
        doc_quc: JSON.stringify([
          "• Wuj rech tzalajik",
          "• Wuj rech q'alajsanik winaqilal"
        ]),
        tel: '1580',
        web: 'www.conamigua.gob.gt'
      },
      {
        codigo: 'CONAMIGUA',
        cat: 'familiar',
        tit_es: 'Asesoría jurídica y búsqueda de migrantes desparecidos',
        tit_quc: "Tob'anik rech tzukuxik winaq e tz'akinaq",
        req_es: JSON.stringify([
          "1. Completar la Ficha Única de Búsqueda de Migrantes",
          "2. Entrevista con la Unidad de Atención y Protección Jurisdiccional",
          "3. Aportar datos de la última ubicación o contacto conocido"
        ]),
        req_quc: JSON.stringify([
          "1. Utz'ib'axik wuj rech tzukunik",
          "2. Ch'ab'enik rech tob'anik legal",
          "3. Ya'ik k'olib'al rech uq'ab'"
        ]),
        doc_es: JSON.stringify([
          "• Fotografía reciente del migrante desaparecido",
          "• DPI del familiar que realiza el reporte",
          "• Fe de bautismo o certificado de nacimiento para comprobar parentesco"
        ]),
        doc_quc: JSON.stringify([
          "• Wachib'al rech winaq",
          "• DPI rech achalal",
          "• Wuj rech alaxib'al"
        ]),
        tel: '1580',
        web: 'www.conamigua.gob.gt'
      },

    
      {
        codigo: 'IGM',
        cat: 'extranjero',
        tit_es: 'Emisión de Pasaporte Guatemalteco por primera vez',
        tit_quc: "Nab'ey Ya'ik rech Pasaporte",
        req_es: JSON.stringify([
          "1. Programar cita en línea en el portal de IGM",
          "2. Boleta de pago de $50.00 en banco autorizado",
          "3. Presencia física en centro de emisión"
        ]),
        req_quc: JSON.stringify([
          "1. Ch'ab'enik pa k'amasaq IGM",
          "2. Wuj rech tojb'al ($50.00)",
          "3. B'ek pa q'atb'al tzij"
        ]),
        doc_es: JSON.stringify([
          "• DPI vigente en original y copia",
          "• Certificado de Nacimiento si es menor de edad",
          "• Copia de DPI de ambos padres si aplica"
        ]),
        doc_quc: JSON.stringify([
          "• DPI tz'akat xukuje' peraj",
          "• Wuj rech alaxib'al rech ak'al",
          "• DPI rech nan xukuje' tat"
        ]),
        tel: '2411-2411',
        web: 'igm.gob.gt'
      },
      {
        codigo: 'IGM',
        cat: 'retornado',
        tit_es: 'Certificación de Arribo y Estatus Migratorio',
        tit_quc: "Wuj rech q'alajsanik opanem pa tinamit",
        req_es: JSON.stringify([
          "1. Solicitud dirigida a la Dirección de Extranjería",
          "2. Pago de arancel administrativo (Q 75.00)",
          "3. Indicar fecha aproximada de ingreso al país"
        ]),
        req_quc: JSON.stringify([
          "1. Tz'ib'anik wuj re IGM",
          "2. Tojb'al (Q 75.00)",
          "3. Ya'ik q'ij rech opanem"
        ]),
        doc_es: JSON.stringify([
          "• DPI original del solicitante",
          "• Pase de abordaje o salvoconducto de retorno"
        ]),
        doc_quc: JSON.stringify([
          "• DPI tz'akat",
          "• Wuj rech tzalajik"
        ]),
        tel: '2411-2411',
        web: 'igm.gob.gt'
      },


      {
        codigo: 'MSPAS',
        cat: 'retornado',
        tit_es: 'Evaluación Médica General y Vacunación',
        tit_quc: "Rilawik Raxnaqil xukuje' Kunabal",
        req_es: JSON.stringify([
          "1. Acudir al puesto o centro de salud público más cercano",
          "2. Registro en el libro de consulta externa",
          "3. Pasar a clínica de triaje y chequeo general"
        ]),
        req_quc: JSON.stringify([
          "1. B'ek pa kunab'al rech tinamit",
          "2. Tz'ib'anik pa wuj rech kunab'al",
          "3. Rilawik pa clínica"
        ]),
        doc_es: JSON.stringify([
          "• DPI o Pase de Retorno",
          "• Carné anterior de vacunación (si lo posee)"
        ]),
        doc_quc: JSON.stringify([
          "• DPI o Wuj rech tzalajik",
          "• Carné rech kunab'al"
        ]),
        tel: '1537',
        web: 'www.mspas.gob.gt'
      },

      // MINTRAB
      {
        codigo: 'MINTRAB',
        cat: 'retornado',
        tit_es: 'Ventanilla de Empleo y Certificación INTECAP',
        tit_quc: "K'amowik pa chak xukuje' wuj INTECAP",
        req_es: JSON.stringify([
          "1. Inscribirse en el Servicio Nacional de Empleo (SNE)",
          "2. Entrevista de perfilado laboral para validar experiencia técnica obtenida en el extranjero",
          "3. Evaluación práctica en INTECAP para recibir título de competencia laboral"
        ]),
        req_quc: JSON.stringify([
          "1. Tz'ib'anik pa SNE",
          "2. Ch'ab'enik rech eta'manik chak",
          "3. Rilawik chak pa INTECAP"
        ]),
        doc_es: JSON.stringify([
          "• DPI original",
          "• Diploma, cartas de recomendación o fotos de trabajos realizados en el extranjero",
          "• Constancia de retorno emitida por CONAMIGUA/IGM"
        ]),
        doc_quc: JSON.stringify([
          "• DPI tz'akat",
          "• Wuj rech chakub'al",
          "• Wuj rech tzalajik"
        ]),
        tel: '1511',
        web: 'www.mintrabajo.gob.gt'
      },

      // SBS
      {
        codigo: 'SBS',
        cat: 'familiar',
        tit_es: 'Programa de Apoyo y Reagrupación Familiar de Niñez Migrante',
        tit_quc: "Chajinik xukuje' Riqbal Ib' rech Ak'ala'",
        req_es: JSON.stringify([
          "1. Evaluación psicosocial en la Secretaría de Bienestar Social",
          "2. Inspección domiciliaria para constatar vivienda apta",
          "3. Firma de Acta de Compromiso para reintegración escolar"
        ]),
        req_quc: JSON.stringify([
          "1. Rilawik k'aslemal xukuje' animas",
          "2. Rilawik ja rech achalal",
          "3. Juch'ik wuj rech riqbal ib'"
        ]),
        doc_es: JSON.stringify([
          "• Certificado de Nacimiento del niño, niña o adolescente",
          "• DPI original de los padres o encargado legal",
          "• Constancia de residencia o recibo de servicio básico"
        ]),
        doc_quc: JSON.stringify([
          "• Wuj rech alaxib'al rech ak'al",
          "• DPI rech tat o nan",
          "• Wuj rech ja/k'olib'al"
        ]),
        tel: '1554',
        web: 'sbs.gob.gt'
      }
    ];

    for (const t of tramites) {
      await db.run(`
        INSERT INTO tramites 
        (institucion_codigo, categoria, titulo_es, titulo_quc, requisitos_es, requisitos_quc, documentos_es, documentos_quc, contacto_telefono, contacto_web)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `, [t.codigo, t.cat, t.tit_es, t.tit_quc, t.req_es, t.req_quc, t.doc_es, t.doc_quc, t.tel, t.web]);
    }
  }

  
  const countSedes = await db.get('SELECT COUNT(*) as total FROM sedes');
  if (countSedes.total === 0) {
    const sedesData = [
      ['RENAP', 'RENAP – Sede Central', '21 Calle 1-56, Zona 1, Ciudad de Guatemala', 'Lunes a Viernes, 8:00 – 16:00', '1517', 14.6293, -90.5135],
      ['CONAMIGUA', 'CONAMIGUA – Oficina Central', '13 Calle 3-40, Zona 10, Ciudad de Guatemala', 'Lunes a Viernes, 8:00 – 17:00', '1580', 14.5982, -90.5101],
      ['IGM', 'IGM – Sede Central de Pasaportes', '6ta Avenida 3-11, Zona 4, Ciudad de Guatemala', 'Lunes a Viernes, 7:00 – 15:00', '2411-2411', 14.6180, -90.5160],
      ['MSPAS', 'MSPAS – Sede Central', '11 Avenida 7-45, Zona 11, Ciudad de Guatemala', 'Lunes a Viernes, 8:00 – 16:30', '1537', 14.6050, -90.5400],
      ['MINTRAB', 'MINTRAB – Edificio Central', '7a Avenida 3-33, Zona 9, Edificio Torre Empresarial', 'Lunes a Viernes, 8:00 – 16:00', '1511', 14.6120, -90.5180],
      ['SBS', 'SBS – Sede Administrativa', '32 Calle 9-34, Zona 11, Las Charcas', 'Lunes a Viernes, 8:00 – 16:30', '1554', 14.5890, -90.5520]
    ];

    for (const s of sedesData) {
      await db.run(`
        INSERT INTO sedes (institucion_codigo, nombre, direccion, horario, telefono, latitud, longitud)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      `, s);
    }
  }

  return db;
}

function getDB() {
  return db;
}

module.exports = { initDB, getDB };