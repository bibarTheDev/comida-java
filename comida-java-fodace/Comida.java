import java.util.ArrayList;
import javax.swing.*;
import javax.swing.table.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;
import java.awt.*;
import java.awt.event.*;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.JPanel;

class Comida extends JFrame implements ActionListener, MouseListener
{
    //utilidades
    Banco db;
    //UI - tela principal
    JScrollPane panComida;
    JMenuBar mnbarBarrinea;
    JMenu batitRelatorio;
    JMenuItem menuitPratos, menuitIngredientes, menuitRelacao;
    JTable tbComida;
    JButton btAddComida, btSair, btAddIngr, btRmComida, btEditComida;
    JLabel lbInfo, imgLogo;
    
    
    /**
     * contrutor, aquele monte de coisa chata pra builda UI serio quem em SA CONSCIENCIA escolhe fazer UI em java
     */
    Comida ()
    {
        //basico
        super("~ Restaurante Java ~");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(900, 470);
        setLocation(100, 100);
        setLayout(null);    
        
        //banco
        this.db = new Banco("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
        //this.db = new Banco("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
        
        //menu bar
        mnbarBarrinea = new JMenuBar();
        setJMenuBar(mnbarBarrinea);
        
        //menu bar item relatorio 
        batitRelatorio = new JMenu("Relatorio");
        mnbarBarrinea.add(batitRelatorio);

        //menu item prato
        menuitPratos = new JMenuItem("Pratos");
        menuitPratos.addActionListener(this);
        batitRelatorio.add(menuitPratos);

        //menu item ingredientes
        menuitIngredientes = new JMenuItem("Ingredientes");
        menuitIngredientes.addActionListener(this);
        batitRelatorio.add(menuitIngredientes);
        
        //menu item relacao
        menuitRelacao = new JMenuItem("Relacao");
        menuitRelacao.addActionListener(this);
        batitRelatorio.add(menuitRelacao);


        //tabela comida
        tbComida = createComidas();
        panComida = new JScrollPane(tbComida);
        panComida.setSize(650, 300);
        panComida.setLocation(20, 20);
        this.add(panComida);
        
        
        //botao adicionar ingrediente
        btAddIngr = new JButton("Adicionar ingrediente");
        btAddIngr.addActionListener(this);
        btAddIngr.setSize(200, 20);
        btAddIngr.setLocation(20, 340);
        this.add(btAddIngr);

        //botao adicionar comida
        btAddComida = new JButton("Adicionar prato");
        btAddComida.addActionListener(this);
        btAddComida.setSize(200, 20);
        btAddComida.setLocation(20, 370);
        this.add(btAddComida);

        //botao remover comida
        btRmComida = new JButton("Remover prato");
        btRmComida.addActionListener(this);
        btRmComida.setSize(200, 20);
        btRmComida.setLocation(240, 340);
        this.add(btRmComida);

        //botao editar comida
        btEditComida = new JButton("Editar prato");
        btEditComida.addActionListener(this);
        btEditComida.setSize(200, 20);
        btEditComida.setLocation(240, 370);
        this.add(btEditComida);

        //botao editar comida
        btSair = new JButton("Sair");
        btSair.addActionListener(this);
        btSair.setSize(200, 20);
        btSair.setLocation(690, 370);
        this.add(btSair);


        //label infos
        lbInfo = new JLabel("");
        lbInfo.setSize(190, 300);
        lbInfo.setLocation(690, 20);
        this.add(lbInfo);
        

        //imagem
        try{
            BufferedImage fota = ImageIO.read(new File("./imagens/logo.png"));
            imgLogo = new JLabel(new ImageIcon(fota));
            imgLogo.setBounds(460, 340, 150, 50);
            add(imgLogo);            
        } 
        catch(Exception ex){
            ex.printStackTrace();
        }


        setVisible(true);
    }

    /**
     * responsividade dos botoes etc etc
     * 
     * @param ev evento que foi disparado
     */
    public void actionPerformed(ActionEvent ev)
    {
        if(ev.getSource() == btAddIngr){ addIngrediente(); return; }
        if(ev.getSource() == btRmComida){ deletePrato(); return; }
        if(ev.getSource() == btAddComida){ addPrato(); return; }
        if(ev.getSource() == btEditComida){ editPrato(); return; }
        if(ev.getSource() == menuitPratos){ relatPratos(); return; }
        if(ev.getSource() == menuitIngredientes){ relatIngredientes(); return; }
        if(ev.getSource() == menuitRelacao){ relatRelacao(); return; }
        if(ev.getSource() == btSair){ System.exit(0); return; }
    }

    /**
     * responsividade do mouse
     * 
     * @param ev evento que foi disparado
     */
    public void mouseClicked(MouseEvent ev) 
    {
        if(ev.getSource() == tbComida){ loadComida(); return; }
    }

    /**
     * responsividade do mouse (nao utilizdos)
     * 
     * @param ev evento que foi disparado
     */
    public void mouseExited(MouseEvent ev) { }
    public void mouseEntered(MouseEvent ev) { }
    public void mouseReleased(MouseEvent ev) { }
    public void mousePressed(MouseEvent ev) { }


    public void relatPratos() { gerarRelat("pratos"); }
    public void relatIngredientes() { gerarRelat("ingredientes"); }
    public void relatRelacao() { gerarRelat("relacao"); }

    /**
     * gera o relatorio jasperrelatorio
     * 
     * @param tabela qual tabela gera
     */
    public void gerarRelat(String tabela)
    {
        String sql = "";
        String relatName = "";
       
        if(tabela == "pratos"){
            relatName = "report-comida";
            sql = "SELECT * FROM comida; ";
        }
        else if(tabela == "ingredientes"){
            relatName = "report-ingredientes";
            sql = "SELECT * FROM ingredientes; ";
        }
        else if(tabela == "relacao"){
            relatName = "report-rela";
            sql = "SELECT com.nome AS cnome, ingr.nome AS inome FROM rel_ingredientes AS rel ";
            sql += "JOIN comida AS com ON rel.comida = com.id ";
            sql += "JOIN ingredientes AS ingr ON rel.ingr = ingr.id; ";
        }

        Relatorio rel = new Relatorio("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
        //Relatorio rel = new Banco("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
        rel.gerar(sql, relatName);
    }


    /**
     * atualiza a view de uma tabela
     * 
     * @param query de onde buscar os dados
     * @param table a tabela
     */
    public void updateTable(String query, JTable table)
    {
        //atualiza a view
        try{    
            ArrayList< ArrayList<String> > data = db.selectQuery(query);
    
            //preenchimento de dados
            loadDataToTable(table, data);
        }
        catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Erro", 0);
        }
    }

    /**
     * atualiza a tabela comida
     */
    public void atualizaComida() { updateTable("SELECT id, nome, peso_volume, descricao FROM comida", this.tbComida); }

    /**
     * adiciona um novo prato ao banco
     */
    public void addPrato()
    {
        //form
        this.setVisible(false);
        AddPratoForm form = new AddPratoForm(this);
    }

    /**
     * edita um prato no banco
     */
    public void editPrato()
    {
        //pega o id
        int row = tbComida.getSelectedRow();
        if(row == -1){
            JOptionPane.showMessageDialog(null, "Nenhum prato selecionado", "Aviso", 1);    
            return;
        }
        String id = (String)this.tbComida.getValueAt(row, 0);

        //form
        this.setVisible(false);
        EditPratoForm form = new EditPratoForm(this, id);
    }

    /**
     * adiciona um ingrediente ao banco
     */
    public void addIngrediente()
    {
        //input
        String nome =  JOptionPane.showInputDialog("Nome do ingrediente");

        //valida
        if(nome == null || nome.trim().length() == 0){
            JOptionPane.showMessageDialog(null, "Nenhum dado inserido", "Aviso", 1);
            return;
        }

        //insere no banco
        try{
            String sql = "INSERT INTO ingredientes VALUES (default, '" + nome + "');";
            if(!this.db.noReturnQuery(sql)){
                throw new Exception("sla kk");
            }
        } 
        catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Erro", 0);
        }
    }

    public void deletePrato()
    {
        //valida
        int row = tbComida.getSelectedRow();
        if(row == -1){
            JOptionPane.showMessageDialog(null, "Nenhum prato selecionado", "Aviso", 1);    
            return;
        }

        //confirma
        int resp = JOptionPane.showConfirmDialog(null, "Deseja mesmo deletar este item?", "Aviso", JOptionPane.YES_NO_OPTION);
        if (resp != JOptionPane.YES_OPTION){
            return;
        }

        //pega a linha
        String id = (String)this.tbComida.getValueAt(row, 0);

        //deleta do banco
        try{
            String sql = "DELETE FROM rel_ingredientes WHERE comida = " + id + ";";
            if(!this.db.noReturnQuery(sql)){
                throw new Exception("Erro ao remover o prato");
            }

            sql = "DELETE FROM comida WHERE id = " + id + ";";
            if(!this.db.noReturnQuery(sql)){
                throw new Exception("Erro ao remover o prato");
            }

            //atualiza a tabela
            try{
                
                sql = "SELECT id, nome, peso_volume, descricao FROM comida";    
                ArrayList< ArrayList<String> > pratos = db.selectQuery(sql);
        
                //preenchimento de dados
                loadDataToTable(this.tbComida, pratos);
            }
            catch(Exception ex){
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, ex.getMessage(), "Erro", 0);
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Erro", 0);
        }
        
        //atualiza a view
        atualizaComida();
    }

    /**
     * builda um objeto tabela genericamente
     * 
     * @param cols array com todos os nomes de colunas
     * @param widths array 2D com os valores min e max das colunas. Length principal deve ser o mesmo de cols, length secundario deve ser 2
     * @return objeto JTable pronto
     */
    public JTable buildTable(String[] cols, int[] width)
    {
        if(cols.length != width.length){
            return null;
        }
        
        //cria o modelo de tabela
        DefaultTableModel model = new DefaultTableModel()
        {
            public boolean isCellEditable(int lin, int col) { return false; }
        };
        //seta as colunas
        for(String col : cols) {
            model.addColumn(col);
        }

        //cria a tabela em si
        JTable tabela = new JTable(model);
        tabela.addMouseListener(this);
        // tabela.addKeyListener(this);
        tabela.getTableHeader().setReorderingAllowed(false);
        //seta min e max width pras cols
        for(int i = 0; i < cols.length; i++){
            tabela.getColumnModel().getColumn(i).setWidth(width[i]);
        }

        return tabela;
    }

    /**
     * carrega um set de dados em uma tabela
     * 
     * @param tabela a tabela no qual os dados vao ser adicionados
     * @param dados lista bidimensional os dados que vao ser adicionados
     */
    public void loadDataToTable(JTable tabela, ArrayList< ArrayList<String> > dados)
    {
        //modelo da tabela
        DefaultTableModel modelo = (DefaultTableModel) tabela.getModel();
        int rowSize;
        try{
            rowSize = dados.get(0).size();
        } 
        //sem dados
        catch(IndexOutOfBoundsException ex){
            return;
        }

        //limpa tabela
        while(modelo.getRowCount() > 0){
            modelo.removeRow(0);
        }

        //preenchimento de dados
        for(ArrayList<String> rows : dados){
            //objeto linha
            String[] row = new String[rowSize];
            for(int i = 0; i < rowSize; i++){
                row[i] = rows.get(i);
            }
            //insert na tabela
            modelo.addRow(row);
        }
    }

    /**
     * seleciona todos os ingredisentes de uma comida e carrega ele numa janelinha ou algo assim
     */
    public void loadComida()
    {
        //pega os ingredientes
        int row = tbComida.getSelectedRow();
        String id = (String)this.tbComida.getValueAt(row, 0);

        String sql = "SELECT ingr.nome FROM rel_ingredientes AS rel " + 
            "JOIN ingredientes AS ingr ON rel.ingr = ingr.id " +
            "WHERE rel.comida = " + id + ";";
        ArrayList< ArrayList<String> > ingrs = db.selectQuery(sql);

        //joga os valores na tela
        //sim, essa gambiarra com html funciona por incrivel que pareca
        String info = "<html>";
        info += "<h3>" + this.tbComida.getValueAt(row, 1) + "</h3>";
        info += "<p>" + this.tbComida.getValueAt(row, 3) + "</p>";
        info += "<p>" + this.tbComida.getValueAt(row, 2) + "</p>";
        info += "<ul>";
        for(ArrayList<String> ingr : ingrs){
            info += "<li>" + ingr.get(0) + "</li>";
        }
        info += "</ul></html>";
        this.lbInfo.setText(info);
    }

    /**
     * carrega todas as comidas numa tabela
     * 
     * @return a tabela construida  
     */
    public JTable createComidas()
    {
        //criacao do objeto
        String[] cols = {"id", "prato", "peso/volume", "descricao"};
        int[] width = {50, 200, 100, 300};
        JTable tabela = buildTable(cols, width);

        //query
        String sql = "SELECT id, nome, peso_volume, descricao FROM comida";    
        ArrayList< ArrayList<String> > pratos = db.selectQuery(sql);
        //preenchimento de dados
        loadDataToTable(tabela, pratos);

        return tabela;
    }
}