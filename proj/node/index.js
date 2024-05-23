const express = require('express');
const app = express();
const port = 80;

let is500 = false;

app.get('/', (req, res) => {
  if (is500) {
    res.sendStatus(500);
  } else {
    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Welcome</title>
          <style>
            body {
              font-family: Arial, sans-serif;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 100vh;
              background-color: #f0f0f0;
              margin: 0;
            }
            .container {
              text-align: center;
              background: white;
              padding: 20px;
              border-radius: 10px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            button {
              padding: 10px 20px;
              font-size: 16px;
              cursor: pointer;
              background-color: #007bff;
              color: white;
              border: none;
              border-radius: 5px;
              transition: background-color 0.3s ease;
            }
            button:hover {
              background-color: #0056b3;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Welcome</h1>
            <p>Press this button to be redirected to our 500 status page.</p>
            <button onclick="redirectToAPI()">Server Error</button>
          </div>
          <script>
            function redirectToAPI() {
              fetch('/set500')
                .then(() => {
                  // Assuming you want to reload the page after setting is500 to true
                  window.location.reload();
                })
                .catch((error) => {
                  console.error('Error:', error);
                });
            }
          </script>
        </body>
      </html>
    `);
  }
});

app.get('/set500', (req, res) => {
  is500 = true;
  res.sendStatus(200);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
