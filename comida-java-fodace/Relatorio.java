import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.extensions.*;
import net.sf.jasperreports.view.JasperViewer;
import java.sql.*;
import java.util.*;
import java.awt.*;
import javax.swing.*;
import java.lang.*;
import java.io.*;

public class Relatorio extends Banco
{	
	/**
     * construtor (overload com schema)
     * 
     * @param host o endererco de onde o banco esta
     * @param port a porta da onde o banco esta
     * @param user usuario para autenticacao no banco
     * @param pass senha para autenticacao no banco
     * @param database qual database conectar
     * @param schema schema dentro do banco
     */
    public Relatorio(String host, String port, String user, String pass, String database, String schema)
	{
		super(host, port, user, pass, database, schema);
	}
	
	/**
     * construtor (overload com schema)
     * 
     * @param host o endererco de onde o banco esta
     * @param port a porta da onde o banco esta
     * @param user usuario para autenticacao no banco
     * @param pass senha para autenticacao no banco
     * @param database qual database conectar
     */
    public Relatorio(String host, String port, String user, String pass, String database)
	{
		super(host, port, user, pass, database);
	}
	
    public void gerar(String query, String jasperName)
    {
    	try{
			//conecta
            boolean res = this.conecta();
            if(!res){
                throw new Exception("impossivel conectar ao banco");
			}
		
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
	
			JRResultSetDataSource jrRS = new JRResultSetDataSource(rs);
			Map parametros = new HashMap();
			
			//only windows
			JasperPrint impressao = JasperFillManager.fillReport("C:\\Users\\ra1757052\\"+jasperName+".jasper", parametros, jrRS);
			JasperViewer viewer = new JasperViewer(impressao, false);
			viewer.show();
			
			st.close();
		}
		catch(Exception ex)    	{
    		JOptionPane.showMessageDialog(null,ex.getMessage(), "Erro", 1);
    	}
    }
}