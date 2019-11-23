/**
 * carrega uma tabela de relatorio de banco (basicamente um dump) por meio de um get request
 * 
 * @param selection qual tabela 
 */ 
function loadRelatorio(selection)
{
    let params = {teste: teste, selection: selection};
    $.get(path + "model/interfaces-java/tabela-generica.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            document.getElementById("table-5").innerHTML = response;
        }
        //else erro
        else{
            alert("Erro ao carregar tabela");
            console.log(response);
            document.getElementById("table-5").innerHTML = response;
        }
    });
}