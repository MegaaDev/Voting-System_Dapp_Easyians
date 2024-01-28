export function encrypt(publicKey, mg, modVal) {
  // publicKey -> e
  // modVal -> n
  var salt = Math.floor(Math.random() * 9) + 1;
  mg = mg * 10 + salt;
  var ct = mg;
  for (var i = 0; i < publicKey - 1; i++) {
    ct = (ct * mg) % modVal;
  }
  return ct;
}
