<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		
        <script src="http://ajax.cdnjs.com/ajax/libs/underscore.js/1.3.3/underscore-min.js"></script>
        <script src="http://ajax.cdnjs.com/ajax/libs/backbone.js/0.9.2/backbone-min.js"></script>
                			    
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="status" role="complementary">
		    <H1>TODO APP</h1>
		    
		    <table>
		        <thead>		    
    		        <th>Name</th>
		            <th>Description</th>
		            <th>Remove</th>
		        </thead>
    		    <!-- print out all the rows -->
    		    <tbody id="todoRows">
		    
    		    </tbody>		    
		    </table>    		    
		    <br/>
		    
		    <g:form controller="home">
		        Name : <g:textField name="name"/><br/>
		        Desc : <g:textField name="desc"/><br/>		        
		        
		        <input type="button" value="add" id="addTodo">
		    </g:form>
		    
		</div>
	
	
	<script>
        // Our TODO Model Object
        var Todo = Backbone.Model.extend({
            defaults : {
                name : 'N/A',
                desc : 'Some Description'
            }
        });
        
        // collection of Todos
        var TodoList = Backbone.Collection.extend({
            model : Todo
        });
        
        // The TODO view is going to be in charge of writing out the TR row
        var TodoView = Backbone.View.extend({
            tagName :  'tr',
            
            intialize : function() {
                // any function that needs to use this needs to be bound
                _.bindAll(this, "render");
            },
            
            render : function() {
                var mod = this.model;
                $(this.el).html("<td>"+mod.get("name")+"</td><td>"+mod.get("desc")+"</td><td><a href='#' class='removeTodo' id='"+mod.cid+"'>Remove</a></td>");
                return this;   // for chainables lke .render().el
            }
        });
        
        // The todo list view is in charge of the collection of all of them
        var TodoListView = Backbone.View.extend({
            el: 'body',//$('body'),
            vars : {},
            
            events : {
                'click #addTodo' : 'createTodo',
                'click .removeTodo' : 'removeTodo'
            },
            
            initialize : function(varName) {
                _.bindAll(this, 'render', 'createTodo', 'appendTodo', 'removeTodo', 'unappendTodo'); 
                // u need to do this if not it is bound to the singleton
                this.vars = {};
                this.vars.varName = varName;
                
                this.collection = new TodoList();
                this.collection.bind('add', this.appendTodo);
                this.collection.bind('remove', this.unappendTodo);                
                this.collection.bind('reset', this.removeAll);                
                this.render();
            },
            
            render : function() {
            },
            
            // creating of the item
            createTodo : function() {
                var todo = new Todo();
                todo.set({
                    name : $("#name").val(),
                    desc : $("#desc").val()
                });
                this.collection.add(todo);
            },
            
            // the actual appending
            appendTodo : function(todo) {
                var tView = new TodoView({
                    model : todo
                });
                $("#todoRows").append(tView.render().el);                
            },
            
            removeTodo : function(event) {
                var modelId = this.$(event.currentTarget).attr("id");
                // grab the model
                var model = this.collection.getByCid(modelId);
                // remove from the collection
                this.collection.remove(model);
            },   
            
            unappendTodo : function(model) {
                $("a[id='"+ model.cid +"'][class='removeTodo']").closest("tr").remove();                
            },       
            
            removeAll : function() {
                // do nicer
                $("#todoRows").html('');
            }              
        });	     
        
        var ourView = new TodoListView("joseph");   
        /*
        $('#addTodo').click(function(event) {
            // then write to focntion
        })
        
        function addItem() {}
        
        function removeItem() {}
        */
    </script>
    
	</body>    
</html>
