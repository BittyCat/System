document.addEventListener('DOMContentLoaded', function ()
{
    var toggleButton = document.getElementById('toggle-mode');
    toggleButton.addEventListener('click', function ()
    {
        var body = document.body;
        if (body.classList.contains('light-mode'))
        {
            body.classList.remove('light-mode');
            toggleButton.classList.remove('btn-light');
            toggleButton.textContent = 'Dark';
        } else
        {
            body.classList.add('light-mode');
            toggleButton.classList.add('btn-light');
            toggleButton.textContent = 'Light';
        }
    });
});