window.addEventListener('load', function(){

  const priceInput = document.getElementById("item-price");
  if (!priceInput) return null;  //学習メモ priceInputなかったら以下は実行しない

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue*0.1);
    

    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);
    

  })
});