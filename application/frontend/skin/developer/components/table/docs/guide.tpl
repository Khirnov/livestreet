{**
 * Таблица
 *}
{test_heading text='Таблица'}

{capture 'test_example_content'}
    <table class="table">
        <thead>
            <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
        </thead>
        <tbody>
            {section name='table_rows' loop=5}<tr>
                <td>{$smarty.section.table_rows.index + 1}</td>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
            {/section}
        </tbody>
    </table>
{/capture}

{test_example content=$smarty.capture.test_example_content}


{**
 * Компактная таблица
 *}
{test_heading text='Компактная таблица'}

<p>Для компактных таблиц используется модификатор <code>condensed</code></p>

{capture 'test_example_content'}
    <table class="table {cmods name='table' mods='condensed'}">
        <thead>
            <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
        </thead>
        <tbody>
            {section name='table_rows' loop=5}<tr>
                <td>{$smarty.section.table_rows.index + 1}</td>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
            {/section}
        </tbody>
    </table>
{/capture}

{test_example content=$smarty.capture.test_example_content showCode=false}


{**
 * Изменение фона рядов при наведении
 *}
{test_heading text='Изменение фона рядов при наведении'}

<p>Для таблиц с рядами, которые изменяют фон при наведении, используется модификатор <code>hover</code></p>

{capture 'test_example_content'}
    <table class="table {cmods name='table' mods='hover'}">
        <thead>
            <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
        </thead>
        <tbody>
            {section name='table_rows' loop=5}<tr>
                <td>{$smarty.section.table_rows.index + 1}</td>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
            {/section}
        </tbody>
    </table>
{/capture}

{test_example content=$smarty.capture.test_example_content showCode=false}


{**
 * Зебра
 *}
{test_heading text='Зебра'}

<p>Для зебры используется модификатор <code>striped</code></p>

{capture 'test_example_content'}
    <table class="table {cmods name='table' mods='striped'}">
        <thead>
            <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
        </thead>
        <tbody>
            {section name='table_rows' loop=5}<tr>
                <td>{$smarty.section.table_rows.index + 1}</td>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
            {/section}
        </tbody>
    </table>
{/capture}

{test_example content=$smarty.capture.test_example_content showCode=false}