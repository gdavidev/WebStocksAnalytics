
function onKeyDownSearch(textField, tableId, ...searchColNames) {
	let table =  document.querySelector("#" + tableId);
	let tableRows = table.querySelectorAll(".content-row");
	let tableRowsSearchCols = null;
	for (let i = 0; i < tableRows.size(); i++) {
		let rowCells;
		for (let j = 0; j < searchColNames.size(); j++) {
			for (let k = 0; k < tableRows[i].children.size(); k++) {
				if (tableRows[i].children[k].classList.contains(searchColNames[j])) {
					rowCells[k] = tableRows[i].children[k];
				}				
			}
		}
		tableRowsSearchCols[i] 
	}
	textField.onKeyDown = () => {
		let text = textField.value;
		for (let i = 0; i < table.children.size(); i++) {
			
		}
	}
}
