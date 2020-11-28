package org.pan.util;
public class strFormat {
   public static String Replace(String source, String oldString, String newString) {
        StringBuffer output = new StringBuffer();

        int lengthOfSource = source.length();   
        int lengthOfOld = oldString.length();   

        int posStart = 0;   
        int pos;            

        while ((pos = source.indexOf(oldString, posStart)) >= 0) {
            output.append(source.substring(posStart, pos));

            output.append(newString);
            posStart = pos + lengthOfOld;
        }

        if (posStart < lengthOfSource) {
            output.append(source.substring(posStart));
        }

        return output.toString();
    }

   
    public static String toHtmlInput(String str) {
        if (str == null)    return null;

        String html = new String(str);

        html = Replace(html, "&", "&amp;");
        html = Replace(html, "<", "&lt;");
        html = Replace(html, ">", "&gt;");

        return html;
    }

   
    public static String toHtml(String str) {
        if (str == null)    return null;

        String html = new String(str);

        html = toHtmlInput(html);
        html = Replace(html, "\r\n", "\n");
        html = Replace(html, "\n", "<br>\n");
        html = Replace(html, "\t", "    ");
        html = Replace(html, "  ", " &nbsp;");

        return html;
    }

    
    public static String toSql(String str) {
        String sql = new String(str);
        return Replace(sql, "'", "''");
    }

   
}