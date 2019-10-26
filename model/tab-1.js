
function loadTab1()
{
    $.get(path + "model/interfaces-java/tabela-comidas.jsp", (duckMe) =>{        
        document.getElementById("tab-1").innerHTML = duckMe;
    });
}