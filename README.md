# Formulário Prospect — Albert

Formulário de quiz para captura de leads (e-book), hospedado no GitHub Pages,
com dados salvos no Supabase e enviados ao RD Station Marketing (tag `app_prospector`).

## Estrutura

```
index.html                        → formulário completo (visual + lógica de envio)
supabase/migrations/0001_create_leads.sql → SQL da tabela `leads`
```

## Passo a passo

### 1. Subir este primeiro commit (resolve o erro de branch no Supabase)

```bash
git init
git add .
git commit -m "primeiro commit: formulario + migration"
git branch -M main
git remote add origin https://github.com/comunicacao-albert/formulario-prospect.git
git push -u origin main
```

Depois disso, a branch `main` vai existir e você consegue selecionar "main" na
tela de GitHub Integration do Supabase sem erro.

### 2. Rodar a migration no Supabase

Se a integração com GitHub já estiver rodando, o arquivo em
`supabase/migrations/0001_create_leads.sql` será aplicado automaticamente
no merge para `main`.

Se preferir aplicar manualmente agora: abra o **SQL Editor** no painel do
Supabase e cole o conteúdo do arquivo `0001_create_leads.sql`.

### 3. Preencher as credenciais no `index.html`

No topo do `<script>`, dentro do objeto `CONFIG`:

```js
var CONFIG = {
  SUPABASE_URL: '...',                 // Settings → API → Project URL
  SUPABASE_ANON_KEY: '...',            // Settings → API → anon public key
  RD_STATION_API_KEY: '...',           // token público de conversão do RD Station
  RD_STATION_CONVERSION_IDENTIFIER: 'formulario-ebook-albert',
  RD_STATION_TAG: 'app_prospector'
};
```

⚠️ Use sempre a **anon key** do Supabase (nunca a `service_role`) e o
**token público de conversão** do RD Station (nunca um token OAuth/privado) —
esse arquivo roda no navegador do visitante, então qualquer chave colocada
aqui fica visível para quem inspecionar o código-fonte da página.

### 4. Ativar o GitHub Pages

No repositório: **Settings → Pages → Source: Deploy from a branch → main → / (root)**.

## Segurança

- A tabela `leads` tem Row Level Security habilitado: o público (`anon`)
  só pode **inserir**, nunca ler, alterar ou apagar registros.
- Para consultar os leads, use o painel do Supabase (autenticado) ou crie
  uma rotina server-side com a `service_role key` — nunca no front-end.
