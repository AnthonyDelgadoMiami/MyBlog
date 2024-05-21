//A test function
function sweetAlertBtn() {
    Swal.fire({
      icon: 'success',
      title: 'Button has been clicked',
    })
  }


//loads button event otherwise will not work
  window.addEventListener('load', event => {
    
    document.getElementById('user-delete-form').addEventListener('submit', confirmDelete);
    
  });

 
  function confirmDelete() {

    event.preventDefault()

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
        // Get delete form
        document.getElementById('user-delete-form').submit()
      }

      const deleteButton = document.getElementById('delete-button')
      deleteButton.disabled = false
      delete deleteButton.dataset.disableWith
      
    })
    
  }

  window.addEventListener('load', event => {
    
    document.getElementById('user-workSaved').addEventListener('submit', savedWork);
    
  });


function savedWork() {

    event.preventDefault()
    
    Swal.fire({
      position: 'top-end',
      icon: 'success',
      title: 'Saved!',
      showConfirmButton: false,
      timer: 1000
    }).then(() => {
    document.getElementById('user-workSaved').submit();
  });
}
    