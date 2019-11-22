
window.onload = () =>
{
    loadTable1();
    loadTable2();
    loadTable3();
    
    document.getElementById("tab-3-form").onsubmit = addPrato;
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
            default:
                break;
        }
    });

    return data
}

/**
 * atualiza o preview de dados
 * 
 * @param source o form daond eel vai pegar os dados
 * @param target o objeto HTML que vai receber a previes
 */
function updatePreview(source, target)
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
