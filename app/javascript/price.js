function calc (){
  const calcCommission = document.getElementById("item-price");
  calcCommission.addEventListener("keyup", () => {
    
    const roundDownCommission = Math.floor(calcCommission.value * 0.1);
    const roundDownProfit = Math.floor(calcCommission.value - roundDownCommission);
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    addTaxPrice.innerHTML = `${roundDownCommission}`
    profit.innerHTML = `${roundDownProfit}`
  });
};

window.addEventListener('load', calc);
