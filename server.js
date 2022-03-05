const { createServer } = require('http');

const { PORT = 3000 } = process.env;

createServer((req, res) => {
  const response = require('./Test-TD.json');
  if (req.url !== '/') {
    response.title = `################################ ${req.url} ${response.title}`
  }
  res.end(JSON.stringify(response));
}).listen(PORT, () => console.log(`http://localhost:${PORT}`));
