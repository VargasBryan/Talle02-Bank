package com.bank;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;

public aspect Log {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    Calendar fecha = new GregorianCalendar();
	String typeA = "Transferencia";
	String typeB = "Retiro";
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* money*(..));
    
    after() : success() {
    	
    	BufferedWriter bw;
    	String typeSpanish;
    	
    	try{
    		
    		String type = thisJoinPointStaticPart.getSignature().getName();
    		
    		bw = new BufferedWriter(new FileWriter(file,true));
    		
    		if(thisJoinPointStaticPart.getSignature().getName().equals("moneyMakeTransaction")) {
    			typeSpanish = typeA;
    		}else {
    			typeSpanish = typeB;
    		}
    		
    		//Escribe el tipo de transacci�n en el archivo log.txt.
    		bw.write("Tipo de transacci�n: " + typeSpanish + "\n");
    		
    		//fecha
    		int dia = fecha.get(cal.DAY_OF_MONTH);
    		int mes = fecha.get(cal.MONTH)+1;
    		int a�o = fecha.get(cal.YEAR);
    		
    		//hora
    		int hora = fecha.get(cal.HOUR_OF_DAY);
    		int minuto = fecha.get(cal.MINUTE);
    		int segundo = fecha.get(cal.SECOND);
    		
    		//Escribe la hora y fecha de la transacci�n en el archivo log.txt
    		bw.write("Hora: "+ hora +":" + minuto + ":" + segundo + " Fecha: " + dia +"/" + mes + "/" + a�o + "\n");
    		
    		//Cierra el archivo log.txt
    		bw.close();
    		
    		//comprobaciones
    		System.out.println("Tipo de transacci�n: " + typeSpanish);
    		System.out.println("Hora: "+ hora +":" + minuto + ":" + segundo + " Fecha: " + dia +"/" + mes + "/" + a�o + "\n");
    		System.out.println("Transaccion realizada con �xito");
    	}catch(IOException e) {
    		System.out.println(e.getMessage());
   		}
    	
    }
    
    pointcut example() : call(* create*(..) );
    after() : example() {
    //Aspecto ejemplo: solo muestra este mensaje despu�s de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
}


