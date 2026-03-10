{if $.get.id}
    {var $item = $_modx->getPlaceholder('items')[0]}
{/if}

<div
    x-data
    class="modx-cmp"
    style="overflow: auto; height: 100vh"
>

    <div
        @ajax:sent="$dispatch('database:reload'); details = false"
        id="details"
        class="curlyframework p3 bg-white"
    >

        <div x-init="$dispatch('modal:open')">
        
            <form
                x-target="form"
                id="form"
                method="post"
                class="form"
            >

                <input type="hidden" name="id" value="{$item.id}" />
            
                <div class="w-100 form__item mb4">
                    <label for="title" class="form__label">Title</label>
                    <div  class="form__field--input">
                        <input type="text" name="title" value="{$item.title | htmlent}" class="br1" />
                    </div>
                </div>
            
                <div class="w-100 mb4">
                    <label for="title" class="form__label">Content</label>
                    <div class="form__field--textarea">
                        <textarea name="content" class="br1">{$item.content | htmlent}</textarea>
                    </div>
                </div>

                <button type="submit" class="x-btn primary-button b">Submit</button>

            </form>
        
        </div>

    </div>

</div>