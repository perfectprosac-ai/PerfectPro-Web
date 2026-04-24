/**
 * Valida que @elastic/elasticsearch carrega e, se houver credenciais,
 * chama client.info() na Elastic Cloud.
 *
 * PowerShell (exemplo):
 *   $env:ELASTIC_CLOUD_ID="..."
 *   $env:ELASTIC_API_KEY="..."
 *   npm run test:elastic
 */

const { Client } = require('@elastic/elasticsearch');

async function main() {
  console.log('Carregando @elastic/elasticsearch... OK');

  const cloudId = process.env.ELASTIC_CLOUD_ID;
  const apiKey = process.env.ELASTIC_API_KEY;

  if (!cloudId || !apiKey) {
    console.log('');
    console.log('Sem ELASTIC_CLOUD_ID ou ELASTIC_API_KEY: pulando conexão real.');
    console.log('Defina as duas variáveis e rode de novo para testar o cluster.');
    process.exit(0);
  }

  const client = new Client({
    cloud: { id: cloudId },
    auth: { apiKey },
  });

  const info = await client.info();
  console.log('');
  console.log('Conexão OK:', info.cluster_name, '| Elasticsearch', info.version?.number);
}

main().catch((err) => {
  console.error('');
  console.error('Falha:', err.meta?.body || err.message || err);
  process.exit(1);
});
