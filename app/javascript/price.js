window.addEventListener('DOMContentLoaded', function(){
  const prices = document.getElementById("item-price");

  prices.addEventListener('keyup', function(){
    const price = prices.value;
    const fee = price / 10;
    const profit = (price - fee);
    const tax = document.getElementById("add-tax-price");
    const sale = document.getElementById("profit") 
    if( 300 <= price && price <= 9999999) {
      tax.innerHTML = fee 
      sale.innerHTML = profit
      }else{
      tax.innerHTML = ""
      sale.innerHTML = ""
    }
  })
})