package customJspComponents.formItems;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class TextFieldHandler extends TagSupport {
	private static final long serialVersionUID = 9182930244857991365L;
	private String name;
	private String label;
	private String placeholder;
	private boolean required;
	
	public void setName(String name) {
		this.name = name;
	}
	public void setlabel(String label) {
		this.label = label;
	}
	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}
	public void setRequired(boolean required) {
		this.required = required;
	}
	
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		String elementTemplate =
			"  <div class='form-item'>"
			+ "		<p class='form-item-label'>" + this.label + "</p>"
			+ "		<input type='text' class='form-text-field form-text-box' "
			+ " 			id='" + this.name + "'"
			+ " 			name='" + this.name + "'"
			+ " 			placeholder='" + this.placeholder + "'"
			+ "				required='" + (required ? "true" : "false") + "'>"
			+ "</div>";
		try {
			out.write(elementTemplate);
		} catch (Exception e) {
			System.out.println(e);
		}
		return SKIP_BODY;
	}
}
