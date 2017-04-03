<h1>These are the {{title}}s in the database</h1>
<table>
%for row in rows:
    <tr>
    %for col in row:
        <td>{{col}}</td>
    %end
    </tr>
%end
</table>