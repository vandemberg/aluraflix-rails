# Desafio Aluraflix

Esse projeto foi um desafio preparado pela alura, objetivo é construir uma API REST utilizando qualquer linguagem de programação. Para mais dúvidas procure por ALURA CHALLENGES BACK-END

### Documentação da API:

#### Videos:
  - /videos - GET - Lista todos os vídeos)
    ```
    payload:
    videos: [{id, description, title, url}]
    ```
  - /videos/:id - GET - Detalhes de um vídeo
    ```
    video: {id, description, title, url}
    ```
  - /videos - POST - Criar um vídeo novo
    ```
    REGRAS:
      * title deve conter entre 2..60 caracteres
      * description deve conter entre 6..255 caracteres
      * url deve ser uma URL valida
    params:
    {
      video: {
        description, title, url
      }
    }
    
    payload:
    video: {
      id, description, url, title
    }
    ```
   - /videos/:id - PATCH - Editar um vídeo
     ```
      REGRAS:
        * title deve conter entre 2..60 caracteres
        * description deve conter entre 6..255 caracteres
        * url deve ser uma URL valida
        params: {
          video: {description, title, url}
        }

        payload:
        video: { id, title, descriptionm url }
     ```
   - /videos/:id - DELETE - Remove um vídeo
     ```
     payload:
      NO CONTENTT
     ```
   
### Como rodar o projeto:

Você vai precisar ter instalado:
- ruby 3
- rails 6
- postgresql

iniciando projeto:
- git clone https://github.com/vandemberg/aluraflix-rails
- cd aluraflix-rails
- bundle
- rails db:create
- rails db:migrate
bundle exec rspec
