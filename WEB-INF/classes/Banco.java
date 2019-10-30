package database;

import java.sql.*;
import java.util.ArrayList;

public class Banco{

    protected static Connection conn;
    protected static String url, user, pass, driver;
    protected static boolean areParamsSet = false;
    protected static ArrayList<String> erros;

    /**
     * seta os params para iniciar o banco (overload sem schema)
     * 
     * @param host o endererco de onde o banco esta
     * @param port a porta da onde o banco esta
     * @param dbuser usuario para autenticacao no banco
     * @param password senha para autenticacao no banco
     * @param database qual database conectar
     */
    public static void setParams(String host, String port, String dbuser, String password, String database)
    {
        driver = "org.postgresql.Driver";
        url = "jdbc:postgresql://" + host;
        url += ":" + port;
        url += "/" + database;
        user = dbuser;
        pass = password;
    
        try{
            DriverManager.registerDriver(new org.postgresql.Driver());
            Class.forName(driver);
        }
        catch(Exception ex){
            //fail
            erros.add("Adivinha? isso msm erro no driver dE NOVO: " + ex.getMessage());

            System.out.println("Adivinha? isso msm erro no driver dE NOVO");
            ex.printStackTrace();
        }

        areParamsSet = true;
        erros = new ArrayList<String>();
    }        

    /**
     * seta os params para iniciar o banco (overload com schema)
     * 
     * @param host o endererco de onde o banco esta
     * @param port a porta da onde o banco esta
     * @param dbuser usuario para autenticacao no banco
     * @param password senha para autenticacao no banco
     * @param database qual database conectar
     * @param schema schema dentro do banco
     */
    public static void setParams(String host, String port, String dbuser, String password, String database, String schema)
    {
        driver = "org.postgresql.Driver";
        url = "jdbc:postgresql://" + host;
        url += ":" + port;
        url += "/" + database;
        url += "?currentSchema=" + schema;
        user = dbuser;
        pass = password;
    
        try{
            DriverManager.registerDriver(new org.postgresql.Driver());
            Class.forName(driver);
        }
        catch(Exception ex){
            //fail
            erros.add("Adivinha? isso msm erro no driver dE NOVO: " + ex.getMessage());

            System.out.println("Adivinha? isso msm erro no driver dE NOVO");
            ex.printStackTrace();
        }

        areParamsSet = true;
        erros = new ArrayList<String>();
    }

    /**
     * estabelece uma conexao ao banco
     * 
     * @return se a conexao foi estabelecia ou nao
     */
    protected static boolean conecta()
    {
        try{
            //checa por parametros
            if(!areParamsSet){
                throw new Exception("parametros nao inicializados");
            }

            //abre a conexao
            conn = DriverManager.getConnection(url, user, pass);
            return true;
        }
        catch(Exception ex){
            //fail
            erros.add("Erro ao iniciar a conexao: " + ex.getMessage());
            
            System.out.println("Erro ao iniciar a conexao");
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * encerra a conexao ao banco
     * 
     * @return se a conexao foi encerrada ou nao
     */
    protected static boolean desconecta()
    {
        try{
            conn.close();
            return true;
        }
        catch(Exception ex){
            //fail (???)
            erros.add("Erro ao finalizar a conecxao: " + ex.getMessage());
            
            System.out.println("Erro ao finalizar a conexao");
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * realiza uma query sem retorno no banco (INSERT, UPDATE ou DELETE)
     * 
     * @param query a query a ser realizada no banco
     * @return se a query foi bem-sucedida ou nao
     */
    public static boolean noReturnQuery(String query)
    {
        try{
            //conecta
            boolean res = conecta();
            if(!res){
                throw new Exception("impossivel conectar ao banco");
            }

            //query
            PreparedStatement ps = conn.prepareStatement(query);
            ps.execute();

            //desconecta
            desconecta();

            return true;
        }
        catch(Exception ex){
            //fail
            erros.add("erro ao realizar a query '" + query + "': " + ex.getMessage());
            
            System.out.println("erro ao realizar a query");
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * realiza uma query com retorno no banco (SELECT)
     * 
     * @param query a query a ser realizada no banco
     * @return lista dos elementos que foram selecionados, sendo cada linha uma lista em si, null caso falhe
     */
    public static ArrayList< ArrayList<String> > selectQuery(String query)
    {
        //array list dentro de array list. caos.
        ArrayList< ArrayList<String> > resp = new ArrayList< ArrayList<String> >();

        try{
            //conecta
            boolean res = conecta();
            if(!res){
                throw new Exception("impossivel conectar ao banco");
            }

            //query
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            //adiciona resultados no retorno
            while(rs.next()){
                ArrayList<String> respLinha = new ArrayList<String>();

                //itera sobre as colunas e joga num array list
                for(int col = 1; col <= rs.getMetaData().getColumnCount(); col++){
                    respLinha.add(rs.getString(col));
                }

                //joga o array list num array
                resp.add(respLinha);
            }

            //desconecta
            desconecta();
        }
        catch(Exception ex){
            //fail
            erros.add("erro ao realizar a query '" + query + "': " + ex.getMessage());
            
            System.out.println("erro ao realizar a query");
            ex.printStackTrace();
            resp = null;
        }
        return resp;
    }

    /**
     * retonra a lista de erros ocorridos
     * 
     * @return lista de erros
     */
    public static ArrayList<String> getErrorList()
    {
        return erros;
    }
}