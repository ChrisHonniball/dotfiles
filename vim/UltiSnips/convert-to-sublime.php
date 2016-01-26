<?php

$files = glob('*.snippets');

unset($files[0]);

foreach($files as $filename) {
  $handle = @fopen($filename, "r");

  if(($handle = @fopen($filename, "r"))) {
    while(($line = fgets($handle, 4096)) !== false) {
      // Detect if this line is the begining of a snippet.
      if(preg_match("/^snippet/", $line) === 1) {
        // Extract the name/description for the snippet
        // Expected format: snippet addon-app "Ember Addon Default application.hbs"
        $description = preg_replace("/^snippet ([a-zA-z-\/]+) \"(.*)\"$/", "$2", $line);
        $new_filename = preg_replace( "/\r|\n|\//", "", ucwords(str_replace(
          ['.hbs'],
          [' Template'],
          $description
        ))) . '.sublime-snippet';
        
        error_log($new_filename . ' Snippet Started...');
        
        // Extract the tabTrigger
        $tab_trigger = '<tabTrigger>' . preg_replace("/^snippet ([a-zA-z-]+) \"(.*)\"$/", "$1", $line) . '</tabTrigger>';
        
        // Set the scope
        $scope = '<scope>source.' . preg_replace("/^([a-zA-Z]+)\.(.*)$/", "$1", $filename) . '</scope>';
        
        // Start the content
        $snippet_content = "<content><![CDATA[";
      } else if(preg_match("/^endsnippet$/", $line) === 1) {
        error_log('Snippet Ended...');
        
        // Complete the content
        $snippet_content .= "]]></content>";
        
        $snippet = sprintf(
          "<snippet>\n\t%s\n\t%s\n\t%s\n\t%s\n</snippet>",
          $snippet_content,
          preg_replace( "/\r|\n/", "", $tab_trigger),
          $scope,
          '<description>' . preg_replace( "/\r|\n/", "", $description) . '</description>'
        );
        
        // Wirte the string to a file.
        if(!file_exists('converted/')) {
          mkdir('converted');
        }
        $new_handle = fopen('converted/' . $new_filename, 'w');
        fwrite($new_handle, $snippet);
        fclose($new_handle);
      } else if(preg_match("/^#/", $line) === 1) {
        continue;
      } else if($line === "") {
        continue;
      } else {
        $snippet_content .= $line;
      }
    }
    if(!feof($handle)) {
      echo "Error: unexpected fgets() fail\n";
    }
    fclose($handle);
  }
}
