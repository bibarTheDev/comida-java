/**
 * carrega uma tabela de relatorio de banco (basicamente um dump)
 * 
 * @param id qual tabela 
 */ 
function loadRelatorio(id)
{
    let query = "";

    switch (id) {
        case 1:{
            query = "SELECT * FROM comida ORDER BY id;";
            break;
        }
        case 2:{
            query = "SELECT * FROM ingredientes ORDER BY id;";
            break;
        }
        case 3:{
            query = "SELECT * FROM table ORDER BY comida;";
            break;
        }
        default:
            break;
    }
}