/**
 * Servidor mínimo: POST /enviar-dados → index no Elasticsearch (Elastic Cloud).
 *
 * PowerShell:
 *   $env:ELASTIC_CLOUD_ID="..."
 *   $env:ELASTIC_API_KEY="..."
 *   $env:PORT="3000"
 *   npm run server:elastic
 *
 * Teste (outro terminal):
 *   curl -X POST http://127.0.0.1:3000/enviar-dados -H "Content-Type: application/json" -d "{\"msg\":\"teste\"}"
 */

const express = require('express');
const { Client } = require('@elastic/elasticsearch');

const app = express();
app.use(express.json());

const cloudId = process.env.ELASTIC_CLOUD_ID;
const apiKey = process.env.ELASTIC_API_KEY;

if (!cloudId || !apiKey) {
  console.warn('Aviso: defina ELASTIC_CLOUD_ID e ELASTIC_API_KEY antes de indexar.');
}

const client = new Client({
  cloud: { id: cloudId },
  auth: { apiKey },
});

app.get('/health', (_req, res) => {
  res.json({ ok: true, elasticConfigured: Boolean(cloudId && apiKey) });
});

app.post('/enviar-dados', async (req, res) => {
  try {
    if (!cloudId || !apiKey) {
      res.status(503).json({ error: 'Elastic não configurado (env ausente).' });
      return;
    }
    await client.index({
      index: 'meu-app-logs',
      document: req.body,
    });
    res.send('Enviado para o Elastic!');
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: String(err.meta?.body || err.message || err) });
  }
});

const port = Number(process.env.PORT) || 3000;
app.listen(port, () => {
  console.log(`Servidor http://127.0.0.1:${port}`);
  console.log('POST /enviar-dados | GET /health');
});
