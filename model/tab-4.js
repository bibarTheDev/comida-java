/**
 * prepara a edição de comida na tab 4
 * 
 * @param id id da comida 
 */
async function prepareEditComida(id)
{    
    //pega dados do prato dados do form
    dados = await getAllPratoData(id);
    if(!dados){
        alert("erro ao carregar pratos")
    }
    
    //bota os dados no form
    await loadForm4(dados);

    //muda avisibilidade do conteudo
    document.getElementById("tab-4-noId").className = "tab-4-content-hidden";
    document.getElementById("tab-4-content").className = "tab-4-content";

    //muda a tab
    changeTab(4);

    //atualiza o preview
    updatePreviewFromForm('tab-4-form', 'tab-4-preview');
}

async function loadForm4(dados)
{
    //dados normais
    document.getElementById("form-4-id").value = dados.id;
    document.getElementById("form-4-nome").value = dados.nome;
    document.getElementById("form-4-descr").value = dados.descricao;
    document.getElementById("form-4-pes-vol").value = Number(dados.pesoVolume);
    document.getElementById("form-4-unid").selectedIndex = (dados.unid == "gramas") ? 0 : 1;

    //ingredientes
    document.getElementById("table-4").innerHTML = await getTable4(dados.ingredientes);
}

/**
 * realiza um GET request para uma pagina que processa a tabela de ingrediestes para selecao em html, e retorna o html pronto pra view
 * 
 * @param ingredientes os ingredientes do prato
 * @returns string pro html
 */
async function getTable4(ingredientes)
{
    let htmlstring;

    let params = {teste: teste, edit: true, ingredientes: ingredientes};
    await $.get(path + "model/interfaces-java/tabela-ingredientes-pratos.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            htmlstring = response;
        }
        //else erro
        else{
            alert("Erro ao carregar tabela");
            console.log(response)
            htmlstring = response;
        }
    });

    return htmlstring;
}

/**
 * pega os dados do form e realiza um Get request pra atualizar o prato
 * 
 * @param ev evento submit 
 */
function atualizaPrato(ev)
{
    //data from form
    let data = getFormPratoData("tab-4-form");

    //valiadacao
    if(!data.id || !data.nome || !data.descricao || !data.pesoVolume || !data.ingredientes.length){
        alert("preencha todos os campos e escolha ao menos um ingrediente!");
        return;
    }

    let params = {
        teste: teste, 
        id: data.id,
        nome: data.nome,
        descricao: data.descricao,
        pesoVol: data.pesoVolume,
        unid: data.unid,
        ingredientes: data.ingredientes,
    };
    $.get(path + "model/interfaces-java/edit-comida.jsp", params, (response) =>
    {   
        //if sucesso
        if(response.trim() == "success"){
            alert("Prato atualizado");
        }
        //else erro
        else{
            alert("Erro ao atualizar o prato");
            console.log(response);                
        }
        
        loadTable1();
    });

    //muda a tab
    changeTab(1);

    ev.preventDefault();
}

/**
 * desabilita edicao na tab 4
 */
function closeEdit()
{
    document.getElementById("tab-4-noId").className = "tab-4-content";
    document.getElementById("tab-4-content").className = "tab-4-content-hidden";
}