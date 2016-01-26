<?php

$files = glob('*.snippets');

unset($files[0]);

foreach($files as $filename) {
  $handle = @fopen($filename, "r");

  if(($handle = @fopen($filename, "r"))) {
    while(($line = fgets($handle, 4096)) !== false) {
      // Detect if this line is the begining of a snippet.
      if(preg_match("/^snippet/", $line) === 1) {
        // Extract the parts of the string
        $parts = [];
        preg_match_all("/snippet\s([a-zA-Z-]+)\s\"([a-zA-Z-_\s0-9,':]+)\"(.*)/", $line, $parts);
        
        // Expected format: snippet addon-app "Ember Addon Default application.hbs"
        $description = $parts[2][0];
        $new_filename = preg_replace( "/\r|\n|\//", "", ucwords(str_replace(
          ['.hbs', '.'],
          [' Template', ' '],
          $description
        ))) . '.sublime-snippet';
        
        error_log($new_filename . ' Snippet Started...');
        
        // Extract the tabTrigger
        $tab_trigger = '<tabTrigger>' . $parts[1][0] . '</tabTrigger>';
        
        if($parts[1][0] === 'date' || $parts[1][0] === 'moment') {
          $new_filename = ucwords($parts[1][0]) . ' ' . $new_filename;
        }
        
        // Set the scope
        $scope = current(explode('.', $filename));
        
        // Start the content
        $snippet_content = "<content><![CDATA[";
      } else if(preg_match("/^endsnippet$/", $line) === 1) {
        error_log('Snippet Ended...');
        
        // Complete the content
        $snippet_content .= "]]></content>";
        
        $snippet = sprintf(
          "<snippet>\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n</snippet>",
          $snippet_content,
          '<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->',
          preg_replace( "/\r|\n/", "", $tab_trigger),
          '<!-- Optional: Set a scope to limit where the snippet will trigger -->',
          '<scope>' . $scope . '</scope>',
          '<!-- Optional: Set a description for the snippet. Sublime will default to file name if not present -->',
          '<description>' . $description . '</description>'
        );
        
        // Wirte the string to a file.
        if(!file_exists('converted/')) {
          mkdir('converted');
        }
        
        if(file_exists('converted/' . $new_filename)) {
          $new_filename = strtoupper($scope) . ' ' . $new_filename;
        }
        $new_handle = fopen('converted/' . $new_filename, 'w');
        fwrite($new_handle, $snippet);
        fclose($new_handle);
      } else if(preg_match("/^extends/", $line) === 1) {
        continue;
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
