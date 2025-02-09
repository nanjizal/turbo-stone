package stone.file;

import js.html.FileReader;
import js.html.File;
import js.html.XMLHttpRequest;
import js.Browser;
import js.html.Blob;
import js.html.URL;

class TextFileWeb {
	public static function save_content(file_path:String, content:String) {
		Browser.window.localStorage.setItem(file_path, content);
	}

	public static function get_content(file_path:String) {
		var content = Browser.window.localStorage.getItem(file_path);
		if (content == null) {
			return "";
		}
		return content;
	}

	public static function export_content(file_path:String) {
		var content = get_content(file_path);
		if (content == null) {
			return;
		}

		var blob = new Blob([content]);
		var url = URL.createObjectURL(blob);
		var anchor = Browser.document.createAnchorElement();
		anchor.href = url;
		anchor.download = file_path;
		anchor.click();
		URL.revokeObjectURL(url);
	}

	public static function import_content(file:File) {
		var reader = new FileReader();
		reader.onload = ()->{
			save_content(file.name, reader.result);
		};
		reader.readAsText(file);
	}
}
