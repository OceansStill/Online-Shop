package tag;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.io.*;

public class CalculatorTag extends TagSupport {

    protected int num1 ;
    protected int num2 ;
    protected String  operation ;
    public void setNum1(String num1) throws IOException {this.num1=Integer.parseInt(num1);
        for (Character ch : num1.toCharArray()) {
            if (Character.isLetter(ch)) {
                JspWriter out=pageContext.getOut ();

                out.print("The division cannot be performed");
            }
        }

    }
    public void setNum2(String num2) throws IOException {this.num2=Integer.parseInt(num2);
        for (Character ch : num2.toCharArray()) {
            if (Character.isLetter(ch)) {
                JspWriter out=pageContext.getOut ();

                out.print("The division cannot be performed");
            }}

    }
    public void setOperation(String  operation){this.operation= (String) operation;}
    public int doStartTag()throws JspException{



        try{
            JspWriter out=pageContext.getOut ();




            if(operation.equals("Add")){
                int add=num1+num2;
                out.print("Addition is: "+add);
            }
            else if(operation.equals("Sub")){
                int sub=num1-num2;
                out.print("Substraction is: "+sub);
            }
            else if(operation.equals("mul")){
                int mul=num1*num2;
                out.print("multiplication is: "+mul);
            }
            else if(operation.equals("div")) {
                int div = num1 / num2;
                if (num1 >= num2)
                    out.print("division is: " + div);
                else
                    out.print("The division cannot be performed");

            }
        }catch(Exception e){
            e.printStackTrace();}
        return(SKIP_BODY);
    }

}