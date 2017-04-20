<head>
	<meta charset="utf-8">
    <title>Natural Language Scheduler</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-default">
  		<div class="container-fluid">
    	 <div class="navbar-header">
      		 <a class="navbar-brand" href="/">
        		<img class="home-button" alt="Brand" src="https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678085-house-128.png">
     		 </a>
   		 </div>
  		</div>
	</nav>
  <h1 class="text-center">Here is your updated table:</h1>
  <table class="table table-center">
    %for row in rows:
        <tr> 
        %for col in row:
            <td>{{col}}</td>
        %end
        </tr>
    %end
  </table>
  </body>