package rjavaapp;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class JavaRLab1 {
	public static void getNouns() throws RserveException, REXPMismatchException {
		RConnection rc = new RConnection();
		rc.eval("library(KoNLP)");
		rc.eval("a <- readLines('c:/soykim/R-study/hotel.txt')"); 
		rc.eval("b <- gsub('[^가-힣]',' ', a)"); 
		rc.eval("c <- extractNoun(b) "); 
		rc.eval("d <- unlist(c)");
		rc.eval("e <- table(d)");
		rc.eval("f <- sort(e, decreasing = T)");
		rc.eval("g <- head(f, 10)");
		REXP x = rc.eval("names(g)");
		String[] y = x.asStrings();
		for (int i =0; i < y.length-1; i++) {
			System.out.print(y[i]+ ", ");
		}
		System.out.println(y[y.length-1]);
		rc.close();
	}

	public static void main(String[] args) throws REXPMismatchException, REngineException {
		System.out.print("R이 보내온 최빈 명사들 : ");
		JavaRLab1.getNouns();
	}
}
