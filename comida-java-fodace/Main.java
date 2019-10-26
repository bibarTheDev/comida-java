import javax.swing.*;

class Main{
    
    public static Comida main;

    public static void main(String args[])
    {
        try{
            main = new Comida();
        }
        catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "houve um erro e eu nao sei qual eh kek\n" + ex.getMessage(), "erro kek", 0);    
        }
    }
}