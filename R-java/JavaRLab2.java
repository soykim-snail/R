package rjavaapp;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class JavaRLab2 {
	public static void getNouns() throws RserveException, REXPMismatchException {
		RConnection rc = new RConnection();
		REXP x = rc.eval("imsi <- source('c:/soykim/R-study/lab.R', encoding = 'UTF-8'); imsi$value");
		RList list = x.asList();
		int v_size = list.size();
		int d_length = list.at(0).length();

		int arrayRows = v_size; //2
		int arrayCols = d_length; //10
		String[][] s = new String[arrayRows][]; // 데이터프레임의 변수 갯수로 행의 크기를 정한다.

		for (int i = 0; i < arrayRows; i++) {
			s[i] = list.at(i).asStrings();
		}


		for (int j = 0; j < arrayCols; j++) {
			System.out.println(s[0][j] + " : " + s[1][j]);
		}
		rc.close();

	}

	public static void main(String[] args) throws REXPMismatchException, REngineException {
		System.out.println("R이 보내온 최빈 명사들 :");
		JavaRLab2.getNouns();
	}
}
