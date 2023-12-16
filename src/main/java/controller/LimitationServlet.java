package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BEAN.LimitationBEAN;
import model.BO.LimitationBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;

@WebServlet("/limitation/*")
public class LimitationServlet extends HttpServlet {
    LimitationBO limitationBO = new LimitationBO();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String destination = null;
        String action = req.getPathInfo().substring(1);


        switch (action){
            case "UpdateLimitation":
                try {

                    String idLimit = req.getParameter("idLimit");
                    String userName = req.getParameter("UserName");
                    String limitStarted = LocalDateTime.now().toString();
                    PrintWriter out = resp.getWriter();
                    int result;
                    if("default".equals(idLimit)){
                        result = limitationBO.UpdateLimitation(null,null,userName);
                        out.println("Đã bỏ lệnh xử phạt đến người dùng: "+ userName);
                    }else{
                        result = limitationBO.UpdateLimitation(idLimit,limitStarted,userName);
                        out.println("Đã xử phạt "+userName+": Lệnh xử phạt sẽ áp dụng cho lần đăng nhập tiếp theo của người dùng!");
                    }



                } catch (Exception e) {
                    throw new RuntimeException(e);
                }


                break;
            case "GetTypeLimitation":

                try {
                    ArrayList<LimitationBEAN> limitationList= new ArrayList<>();
                    limitationList = limitationBO.GetAllTypeLimitation();
                    PrintWriter out = resp.getWriter();
                    out.println("<option value='default'>--Chọn hình thức xử phạt--</option>");
                    for(int i=0; i<limitationList.size(); i++){
                        out.println("<option value=\""+limitationList.get(i).getIdLimitation()+"\">"+limitationList.get(i).getTypeLimitation()+"</option>");
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }

                break;
        }
    }

    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {


    }
}