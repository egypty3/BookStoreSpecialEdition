var datatable;
$(function () {
	// jQuery methods go here...
	loadDataTable();
});

function loadDataTable() {
	datatable = $('#tblData').DataTable(
		{
			"ajax": {
				"url": "/Admin/Product/GetAll"
			},
			"columns": [
				{ "data": "title","width":"15%" },
				{ "data": "isbn", "width": "15%" },
				{ "data": "price", "width": "15%" },
				{ "data": "author", "width": "15%" },
				{ "data": "category.name", "width": "15%" },
				{
					"data": "id",
					"render": function (data) {
						return `
							<div class="btn-group" role="group">
								<a href="/Admin/Product/Upsert?id=${data}"
									class="btn btn-primary mx-2"><i class="bi bi-pencil-square"></i> 
									 Edit
								</a>

								<a onclick="Delete('/Admin/Product/Delete?id=${data}')"
									class="btn btn-danger mx-2"><i class="bi bi-trash-fill"></i>
									 Delete
								</a>

							</div>
						`;
					}
				}
			]
		}
	);
}

function Delete(url) {
	//alert(url);
	Swal.fire({
		title: 'Are you sure?',
		text: "You won't be able to revert this!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes, delete it!'
	}).then((result) => {
		if (result.isConfirmed) {
			// actual delete request would be here instead !!
			$.ajax(
				{
					url: url,
					type: 'DELETE',
					success: function (data) {
						if (data.success) {
							datatable.ajax.reload();
							toastr.success(data.message);
						}
						else {
							toastr.error(data.message);
						}

					}
				}
			);
		}
	})
}