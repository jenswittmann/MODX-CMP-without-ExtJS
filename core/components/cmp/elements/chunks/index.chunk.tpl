<div
    x-data="{
        database: false,
        details: false,
        loading: false
    }"
    @ajax:before="loading = true"
    @ajax:sent="loading = false"
    class="modx-cmp"
    style="overflow: auto; height: 100vh"
>

    <div class="curlyframework container">

        <div
            @database:reload.window="$ajax('{$_modx->getPlaceholder('cmp_url')}', { target: 'database' })"
            id="database"
        >
            <h1 class="f3 mb3">{$title}</h1>

            <p class="dib b p2 bg-white">News</p>

            <div class="bg-white">

                <p class="ph2 pv3">This is a simple demo.</p>

                <form x-target="database" id="form" method="post" class="x-panel-mc form flex g3 p2">
                
                    <div>
                        <a
                            x-target="details"
                            href="{$_modx->getPlaceholder('cmp_url')}view=details"
                            class="x-btn primary-button dif g1 b"
                        >
                            <span class="icon icon-plus icon--fa"></span>
                            Add item
                        </a>
                    </div>

                    <div>
                        <label for="title" class="clip">Search</label>
                        <input type="search" name="search" value="{$.post.search | htmlent}" placeholder="Search" class="p1" />
                        <button type="submit" class="x-btn primary-button">
                            <span class="icon icon-search icon--fa"></span>
                        </button>
                    </div>

                </form>

                <table class="w-100">
                    <thead>
                        <th class="x-grid3-header x-grid3-hd-inner" style="width: 20ch">Date</th>
                        <th class="x-grid3-header x-grid3-hd-inner" style="width: 25ch">Title</th>
                        <th class="x-grid3-header x-grid3-hd-inner">Details</th>
                    </thead>
                    <tbody>

                        {if $_modx->getPlaceholder('items') | count == 0}
                            <tr>
                                <td colspan="7" class="p3 tc">No entries.</td>
                            </tr>
                        {/if}

                        {foreach $_modx->getPlaceholder('items') as $i => $item}
                            <tr>
                                <td class="x-grid3-hd-inner v-top {if $i % 2}x-grid3-row-alt{/if}">
                                    {$item.createdon | date_format : "%Y-%m-%d %H:%M"}
                                </td>
                                <td class="x-grid3-hd-inner v-top {if $i % 2}x-grid3-row-alt{/if}">
                                    {$item.title}
                                </td>
                                <td class="x-grid3-hd-inner v-top {if $i % 2}x-grid3-row-alt{/if}">
                                    <a
                                        x-target="details"
                                        href="{$_modx->getPlaceholder('cmp_url')}view=details&id={$item.id}"
                                        class="x-btn"
                                    >Edit</a>
                                </td>
                            </tr>
                        {/foreach}

                    </tbody>
                </table>
            </div>
        </div>

        <div
            x-show="loading"
            class="print-hide fixed top-0 left-0 right-0 bottom-0 bg-white o-50"
        ></div>
        <div
            x-show="details"
            @click="details = false"
            class="print-hide fixed top-0 left-0 right-0 bottom-0 bg-black o-30"
        ></div>
        <div
            x-show="details"
            @modal:open.window="details = true"
            class="fixed top-0 right-0 bottom-0 overflow-auto w-40 print-w-100 p4 bg-white"
        >
            <div id="details"></div>
        </div>

    </div>
</div>

<!-- CurlyFramework -->
<link rel="stylesheet" href="/assets/components/{$namespace}/css/style.css">

<!-- Alpine.js -->
<script defer src="https://cdn.jsdelivr.net/npm/@imacrayon/alpine-ajax@0.12.6/dist/cdn.min.js"></script>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.14.1/dist/cdn.min.js"></script>