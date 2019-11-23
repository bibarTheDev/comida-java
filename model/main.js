
window.onload = () =>
{
    loadTable1();
    loadTable2();
    loadTable3();
    
    document.getElementById("tab-3-form").onsubmit = addPrato;
    document.getElementById("tab-4-form").onsubmit = atualizaPrato;
}

let path = "/comida-java/";
let teste = true;

/**
 * troca os "%20" de uma string por " "
 * 
 * @param str string a ser consertada
 * @returns string consertada 
 */
function fixStringSpace(str)
{
    return str.replace(/%20/g, " ");
}

/**
 * pega os dados do form de adicao ou edicao de pratos e os retorna eum um objeto
 * 
 * @param source id do form no HTML
 * @returns os dados em forma de objeto
 */
function getFormPratoData(source)
{
    //pega dados brutos
    let serialData = $("#"+source).serialize();
    serialData = serialData.split('&');
    
    //cria dataset
    let data = {
        id: "",
        nome: "",
        descricao: "",
        pesoVolume: "",
        unid: "",
        ingredientes: []
    };
    
    //popula dataset
    serialData.forEach(elem => 
    {
        field = elem.split("=");
        switch (field[0]) {
            case "ingredientes":{  
                data.ingredientes.push(fixStringSpace(field[1]));
                break;
            }
            case "nome":{
                data.nome = fixStringSpace(field[1]);
                break;
            }
            case "descr":{
                data.descricao = fixStringSpace(field[1]);
                break;
            }
            case "pes-vol":{
                data.pesoVolume = fixStringSpace(field[1]);
                break;
            }
            case "unid":{
                data.unid = fixStringSpace(field[1]);
                break;
            }
            case "id":{
                data.id = fixStringSpace(field[1]);
                break;
            }
            default:
                break;
        }
    });

    return data
}

/**
 * atualiza o preview de dados do prato a partir de um formulario
 * 
 * @param source o form daond eel vai pegar os dados
 * @param target o objeto HTML que vai receber a previes
 */
function updatePreviewFromForm(source, target)
{
    //pega dados
    let data = getFormPratoData(source);

    //carrega texto
    let content = "<div>";
    content += "<h4>" + data.nome + "</h4>";
    content += "<p>" + data.descricao + "</p>";
    content += "<p>" + data.pesoVolume + " " + data.unid + "</p>";
    content += "<ul>";
    data.ingredientes.forEach(ingrediente => 
    {
        content += "<li>" + ingrediente + "</li>"
    });
    content += "</ul></div>";

    //joga texto na view
    document.getElementById(target).innerHTML = content;
}

/**
 * pega todos os dados relacionandos a um prato
 * 
 * @param id o id do prato
 */
async function getAllPratoData(id)
{
    let dados;
    
    let params = {teste: teste, id: id};
    await $.get(path + "model/interfaces-java/get-comida.jsp", params, (response) =>
    {   
        //if is serial, sucesso
        if(response.trim().startsWith("id=")){
            dados = deserializePrato(response.trim()); 
        }
        //else erro
        else{
            alert("Erro ao carregar dados");
            dados = false;
        }
    });
    return dados;
}

/**
 * desserializa uma string de prato
 * 
 * @param serialPrato a string serializada
 * @returns objeto prato
 */
function deserializePrato(serialPrato)
{
    let pesVolUnid;
    serialPrato = serialPrato.split("&");

    //cria dataset
    let data = {
        id: "",
        nome: "",
        descricao: "",
        pesoVolume: "",
        unid: "",
        ingredientes: []
    };

    //popula dataset
    serialPrato.forEach(elem => 
    {
        field = elem.split("=");
        switch (field[0]) {
            case "ingredientes":{  
                data.ingredientes.push(fixStringSpace(field[1]));
                break;
            }
            case "id":{
                data.id = fixStringSpace(field[1]);
                break;
            }
            case "nome":{
                data.nome = fixStringSpace(field[1]);
                break;
            }
            case "descricao":{
                data.descricao = fixStringSpace(field[1]);
                break;
            }
            case "pesVol":{
                pesVolUnid = fixStringSpace(field[1]).split(" ");
                break;
            }
            default:
                break;
        }
    });

    //fix rapido
    data.pesoVolume = pesVolUnid[0];
    data.unid = pesVolUnid[1];

    return data;
}