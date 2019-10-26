import java.util.ArrayList;
import javax.swing.*;
import javax.swing.table.*;
import javax.swing.event.*;
import javax.swing.table.DefaultTableModel;

import javax.swing.event.DocumentListener;
import java.awt.*;
import java.awt.event.*;
import javax.swing.BorderFactory;

class AddPratoForm extends JFrame implements ActionListener, MouseListener, DocumentListener
{
    //utilidades
    Banco db;
    Comida mainForm;
    ArrayList< String > ingrList;
    //UI - tela principal
    JScrollPane panIngr, panTxDesc;
    JTable tbIngr;
    JTextField txtNome, txtPesVol;
    JTextArea txtDesc;
    //JComboBox< String > selPesVol; //talvez nao funcione no java 6
    JComboBox selPesVol; //talvez nao funcione no java 6
    JButton btAddPrato, btCancela;
    JLabel lbNome, lbPesVol, lbDesc, lbPreview;
    
    /**
     * contrutor, aquele monte de coisa chata pra builda UI serio quem em SA CONSCIENCIA escolhe fazer UI em java
     * 
     * @param Comida o formulario principal que chama esta
     */
    AddPratoForm(Comida form)
    {
        //basico
        super("comdia java fodace");
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        setSize(760, 520);
        setLocation(100, 100);
        setLayout(null);
        this.mainForm = form;
        this.ingrList = new ArrayList<String>();

        //banco
        this.db = new Banco("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
        //this.db = new Banco("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
        
        //tabela comida
        tbIngr = createIngrs();
        panIngr = new JScrollPane(tbIngr);
        panIngr.setSize(540, 300);
        panIngr.setLocation(20, 20);
        this.add(panIngr);
    

        //botao adicionar comida
        btAddPrato = new JButton("Adicionar");
        btAddPrato.addActionListener(this);
        btAddPrato.setSize(160, 20);
        btAddPrato.setLocation(580, 410);
        this.add(btAddPrato);

        //botao cancelar
        btCancela = new JButton("Cancelar");
        btCancela.addActionListener(this);
        btCancela.setSize(160, 20);
        btCancela.setLocation(580, 440);
        this.add(btCancela);


        //textbox nome do prato
        txtNome = new JTextField();
        txtNome.getDocument().addDocumentListener(this);
        txtNome.setSize(180, 20);
        txtNome.setLocation(170, 340);
        this.add(txtNome);

        //textbox peso/volume
        txtPesVol = new JTextField();
        txtPesVol.getDocument().addDocumentListener(this);
        txtPesVol.setSize(60, 20);
        txtPesVol.setLocation(170, 370);
        this.add(txtPesVol);

        //textArea descricao
        txtDesc = new JTextArea();
        txtDesc.getDocument().addDocumentListener(this);
        txtDesc.setLineWrap(true);
        panTxDesc = new JScrollPane(txtDesc);
        panTxDesc.setSize(180, 60);
        panTxDesc.setLocation(170, 400);
        this.add(panTxDesc);
        

        //select peso/volume
        String[] opts = {"gramas", "mililitros"}; //pessimo
        //selPesVol = new JComboBox<String>(opts); //talvez nao funcione no java 6
        selPesVol = new JComboBox(opts); //talvez nao funcione no java 6
        selPesVol.addActionListener(this);
        selPesVol.setSize(120, 20);
        selPesVol.setLocation(230, 370);
        this.add(selPesVol);


        //label txtNome
        lbNome = new JLabel("Nome do Prato:");  
        lbNome.setSize(140, 20);
        lbNome.setLocation(20, 340);
        this.add(lbNome);

        //label txtPesVol
        lbPesVol = new JLabel("Peso ou Volume:");  
        lbPesVol.setSize(140, 20);
        lbPesVol.setLocation(20, 370);
        this.add(lbPesVol);

        //label txtDesc
        lbDesc = new JLabel("Descrição do Prato:");  
        lbDesc.setSize(150, 20);
        lbDesc.setLocation(20, 400);
        this.add(lbDesc);

        //label preview
        lbPreview = new JLabel("Preview");
        lbPreview.setSize(160, 300);
        lbPreview.setLocation(580, 20);
        this.add(lbPreview);
        
        setVisible(true);
    }

    /**
     * responsividade dos botoes
     * 
     * @param ev evento que foi disparado
     */
    public void actionPerformed(ActionEvent ev)
    {
        if(ev.getSource() == btCancela){ volta(); return; }
        if(ev.getSource() == btAddPrato){ addPrato(); return; }
        if(ev.getSource() == selPesVol){ updatePreview(); return; }
    }

    /**
     * responsividade do mouse
     * 
     * @param ev evento que foi disparado
     */
    public void mouseClicked(MouseEvent ev) 
    {
        if(ev.getSource() == tbIngr){ toggleIngr(); return; }
    }

    /**
     * responsividade do mouse (nao utilizado)
     * 
     * @param ev evento que foi disparado
     */
    public void mouseExited(MouseEvent ev) { }
    public void mouseEntered(MouseEvent ev) { }
    public void mouseReleased(MouseEvent ev) { }
    public void mousePressed(MouseEvent ev) { }

    
    /**
     * responsividade dos campos de texto (age como unificador do keyup, keydown e keypress)
     * 
     * @param ev evento que foi disparado
     */
    public void onChange(DocumentEvent ev)
    {
        if(ev.getDocument() == txtNome.getDocument()) { updatePreview(); return; }
        if(ev.getDocument() == txtPesVol.getDocument()) { updatePreview(); return; }
        if(ev.getDocument() == txtDesc.getDocument()) { updatePreview(); return; }
    }
    
    
    /**
     * responsividade dos campos de texto 
     * (as 3 redirecionam pra mesma funcao, porque fazem basicamente a mesma coisa)
     * 
     * @param ev evento que foi disparado
     */
    public void removeUpdate(DocumentEvent ev) { onChange(ev); }
    public void insertUpdate(DocumentEvent ev) { onChange(ev); }
    public void changedUpdate(DocumentEvent ev) { onChange(ev); }

    /**
     * volta para o formulario principal
     */
    public void volta()
    {
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        this.dispatchEvent(new WindowEvent(this, WindowEvent.WINDOW_CLOSING));
        this.mainForm.setVisible(true);
        this.mainForm.atualizaComida();
    }

    /**
     * valida os inputs para adicao do prato, 
     * adiciona ele no banco 
     * e retorna ao formulario principal
     */
    public void addPrato()
    {
        //valida
        String val = valida();
        if(val != ""){
            JOptionPane.showMessageDialog(null, val, "Aviso", 1);
            return;
        }

        //insere no banco
        String[] valores = {
            txtNome.getText().trim(),
            txtPesVol.getText().trim() + " " + selPesVol.getSelectedItem(),
            txtDesc.getText().trim()
        };
        //eu sei que isso ta mt mal otimizado (3 quers) mas... eh o preco que se paga pela organizacao 
        try{
            //insere o prato
            String sql = "INSERT INTO comida VALUES (default, '" + valores[0] + "', '" + valores[1] + "', '" + valores[2] + "'); ";
            db.noReturnQuery(sql);

            //pega o ultimo
            ArrayList< ArrayList<String> > resp;
            String id;
            sql = "SELECT id FROM comida ORDER BY ID DESC LIMIT 1; ";
            resp = db.selectQuery(sql);
            id = resp.get(0).get(0); 

            //add os ingrdedientes
            sql = "INSERT INTO rel_ingredientes VALUES";
            for(int i = 0; i < ingrList.size(); i++){
                //adiciona o id da comida (ja obtido) e seleciona o id de cada ingrediente pra adicionar junto
                sql += "( " + id + ", (SELECT id FROM ingredientes WHERE nome = '" + ingrList.get(i) + "'))";
                sql += (i == (ingrList.size() - 1)) ? ";" : ",";
            }
            db.noReturnQuery(sql);
        } 
        catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Erro", 1);
            return;
        }

        this.volta();
    }

    /**
     * adiciona um ingrediente a lista de ingredientes caso ele nao esteja nela,
     * ou remove um ingrediente se ele ja estiver na lista, e depois atualiza a view 
     */
    public void toggleIngr()
    {
        //pega o ingredientes
        int row = tbIngr.getSelectedRow();
        String nome = (String)this.tbIngr.getValueAt(row, 1);
        int len = ingrList.size();

        //adiciona na lista caso nao exista, remove caso contrario
        int i = 0;

        for(String ingr : this.ingrList) {
            //remove
            if(ingr.equals(nome)){
                this.ingrList.remove(i);
                break;
            }
            i++;
        }
        //if percorreu a lista toda (ou seja, nao achou)
        if(i == len){
            this.ingrList.add(nome);
        }

        //update view
        updatePreview();    
    }

    /**
     * valida todos os campos para ver se estao ok
     * 
     * @return mensagem de erro, "" em caso de sucesso
     */
    public String valida()
    {
        //valida campos de texto
        String[] camposTexto = {
            txtNome.getText().trim(),
            txtDesc.getText().trim(),
            txtPesVol.getText().trim()
        };
        for(String value : camposTexto) {
            if(value == null || value.length() == 0){
                return "Preencha todos os campos para adicionar o prato!";
            }
        }

        //valida peso/vol
        for (char ch : camposTexto[2].toCharArray()) {
            if (!Character.isDigit(ch)){
                return "O campo peso/volume deve conter apenas números!";
            }
        }

        //valida ingreientes
        if(this.ingrList.size() < 2){
            return "Selecione ao menos 2 ingredientes para adicionar o prato!";
        }

        //sucesso
        return "";
    }

    /**
     * atualiza a view do label de preview de comida
     */
    public void updatePreview()
    {
        //joga os valores na tela
        String info = "<html>";
        info += "<h3>" + txtNome.getText().trim() + "</h3>";
        info += "<p>" + txtDesc.getText().trim() + "</p>";
        info += "<p>" + txtPesVol.getText().trim() + " " + selPesVol.getSelectedItem() + "</p>";
        info += "<div>";
        for(String ingr : ingrList){
            info += " - " + ingr + "<br>";
        }
        info += "</div></html>";
        this.lbPreview.setText(info);
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
     * carrega todas as comidas numa tabela
     * 
     * @return a tabela construida  
     */
    public JTable createIngrs()
    {
        //criacao do objeto
        String[] cols = {"id", "ingredietne"};
        int[] width = {50, 600};
        JTable tabela = buildTable(cols, width);

        //query
        String sql = "SELECT id, nome FROM ingredientes";    
        ArrayList< ArrayList<String> > pratos = db.selectQuery(sql);
        //preenchimento de dados
        loadDataToTable(tabela, pratos);

        return tabela;
    }
}