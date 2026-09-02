MODICUS PERFORMANCE — CLOUD + VÍDEO + IA

O pacote contém:
- index.html: app atualizada
- manifest.webmanifest
- sw.js
- ícones
- supabase_setup.sql
- supabase_edge_function_analyze-game/index.ts

O que fica disponível:
1. Mesmos dados no tablet, telemóvel e computador com login.
2. Vídeos privados guardados no Supabase Storage.
3. Sincronização do apito inicial com o vídeo.
4. Cada evento da timeline abre o momento correspondente no vídeo.
5. Análise IA de vídeo: a app extrai frames perto dos eventos e envia frames + dados para uma Edge Function.
6. A chave OpenAI fica no servidor (Supabase secret), nunca dentro do index.html.

Passos necessários uma única vez:
A) Criar um projeto Supabase.
B) Executar supabase_setup.sql no SQL Editor.
C) Copiar Project URL e anon/public key para Dados > Sincronização na nuvem, dentro da app.
D) Criar conta na app com o mesmo email/password nos dispositivos.
E) Para IA de vídeo, publicar a Edge Function analyze-game e configurar OPENAI_API_KEY como secret.
F) Substituir os ficheiros do GitHub Pages por index.html, manifest.webmanifest, sw.js e os ícones deste pacote.

Nota:
A IA de vídeo desta versão não envia o vídeo inteiro ao modelo. A app extrai imagens dos momentos relevantes (ex.: ±2 s dos eventos) e cruza-as com os dados registados. É mais rápido, controlável e económico.
