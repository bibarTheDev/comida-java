
window.onload = () =>
{
    loadTable1();
    loadTable2();
    loadTable3();

    document.getElementById("tab-3-form").onsubmit = addPrato;
}

let path = "/comida-java/";
let teste = true;