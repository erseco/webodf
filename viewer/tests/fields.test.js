// Lightweight unit tests for page-number formatting logic used in viewer/index.html
// Run with: `node viewer/tests/fields.test.js`
const assert = require('assert');

function toRoman(num, upper) {
  if (num <= 0) return '0';
  const romans = [[1000,'M'],[900,'CM'],[500,'D'],[400,'CD'],[100,'C'],[90,'XC'],[50,'L'],[40,'XL'],[10,'X'],[9,'IX'],[5,'V'],[4,'IV'],[1,'I']];
  let n=num, r=''; romans.forEach(([v,s])=>{ while(n>=v){ r+=s; n-=v; } });
  return upper ? r : r.toLowerCase();
}
function toAlpha(num, upper){ let n=Math.max(1,num),s=''; while(n>0){ n-=1; s=String.fromCharCode(97+(n%26))+s; n=Math.floor(n/26);} return upper? s.toUpperCase():s; }
function fmt(n,f){ switch((f||'1')){ case 'i': return toRoman(n,false); case 'I': return toRoman(n,true); case 'a': return toAlpha(n,false); case 'A': return toAlpha(n,true); default: return String(n);} }

assert.strictEqual(fmt(1,'1'),'1');
assert.strictEqual(fmt(12,'i'),'xii');
assert.strictEqual(fmt(12,'I'),'XII');
assert.strictEqual(fmt(27,'a'),'aa');
assert.strictEqual(fmt(27,'A'),'AA');
console.log('OK: number formatting');

