package rtest;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;
@Service
public class OnePersonService {	
	public String returnLeaflet(String path, String gu)  {
		RConnection r = null;
		String retStr = "";
		try {
			r = new RConnection(); 
			System.out.println("gu <- iconv('" + gu + "', from = 'CP949', to = 'UTF-8')");
			r.eval("gu <- iconv('" + gu + "', from = 'CP949', to = 'UTF-8')");
			r.eval("source('c:/soykim/R-study/oneMap2.R', encoding = 'UTF-8')");
			String fileName = path + "/oneMap.html";	
			System.out.println(fileName);
			r.eval("saveWidget(oneMap, '" + fileName + "', selfcontained = F)");	        
			retStr = "oneMap.html";
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			r.close(); 
		}
		return retStr;
	}	

}
