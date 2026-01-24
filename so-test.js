const { io } = require("socket.io-client");

const BASE = process.env.BASE;   // ✅ add this
const TOKEN = process.env.TOKEN;
const CONV = process.env.CONV;

if (!BASE) { console.error("missing BASE"); process.exit(2); }
if (!TOKEN) { console.error("missing TOKEN"); process.exit(2); }
if (!CONV) { console.error("missing CONV"); process.exit(2); }

const socket = io(BASE, {
  path: "/ws/socket.io",
  transports: ["websocket"],
  auth: { token: TOKEN },
});

socket.on("connect", () => {
  console.log("✅ connected", socket.id);
  socket.emit("chat:join", { conversationId: CONV });
  socket.emit("chat:send", {
    conversationId: CONV,
    body: "hello from socket ✅"
  });
});

socket.on("chat:joined", (d) => console.log("✅ joined", d));

socket.on("chat:new_message", (m) => {
  console.log("📩 new message:", m);
  process.exit(0);
});

socket.on("connect_error", (e) => {
  console.error("❌ connect_error", e.message);
  process.exit(2);
});
