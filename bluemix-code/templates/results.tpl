<head>
	<meta charset="utf-8">
	<title>Natural Language Scheduler</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<body>
	<h1>These are the {{title}}s in the database</h1>
	{{cols}}
	<table class="table">
	%for row in rows:
	    <tr> 
	    %for col in row:
	        <td>{{col}}</td>
	    %end
	    </tr>
	%end
	</table>

	
	<!-- Bootstrap Core JavaScript -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" 					crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>