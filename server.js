const { createServer } = require('http');

const { PORT = 3000, MAXDEPTH = 5, MAXLINKS = 7 } = process.env;

createServer((req, res) => {
  const links = Math.max(2, parseInt((Math.random() * 1000) % MAXLINKS));
  const response = {
    level: req.url,
    foo: 42,
    bar: 'foobar',
    random: Math.random(),
    date: Date.now(),
    something: ['special', 'data', 'whatever'],
    _links:
      req.url.split('/').filter((x) => x).length > MAXDEPTH
        ? undefined
        : Array(links)
            .fill()
            .map((__, i) => {
              const slug = `${req.url}/level${i}`.replace(/\/\//g, '/');
              return `http://localhost:${PORT}${slug}`;
            }),
  };

  res.end(JSON.stringify(response));
}).listen(PORT, () => console.log(`http://localhost:${PORT}`));
