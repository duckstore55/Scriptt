export default function handler(req, res) {
  const { key, hwid } = req.query;

  const keys = {
    "ABC123": { hwid: null, expira: Date.now() + 3600000 }
  };

  const data = keys[key];

  if (!data) return res.send("invalid");
  if (Date.now() > data.expira) return res.send("expired");

  if (!data.hwid) data.hwid = hwid;

  if (data.hwid !== hwid) return res.send("locked");

  return res.send("valid");
}
