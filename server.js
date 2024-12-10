const express = require("express");
const path = require("path");

const app = express();
const port = 3000;

// Serve static files (XML, XSL, CSS) from the "public" directory
app.use(express.static(path.join(__dirname, "public")));

// Start the Express server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
