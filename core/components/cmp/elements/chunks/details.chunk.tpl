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
            
                <div
                    x-data="{
                        content: '{$item.content | htmlent}',
                    }"
                    x-init="
                        pell.init({
                            element: $refs.editor,
                            onChange: (html) => {
                                content = html;
                            },
                            defaultParagraphSeparator: 'p',
                            actions: [ 'bold' ]
                        });
                        $refs.editor.content.innerHTML = '{$item.content | htmlent}';
                    "
                    class="w-100 mb4"
                >
                    <label for="title" class="form__label">Content</label>
                    <div x-ref="editor" class="pell"></div>
                    <input
                        :value="content"
                        name="content"
                        class="clip"
                    />
                </div>

                <div
                    x-data="{
                        src: ''
                    }"    
                    class="w-100 mb4"
                >
                    <label for="image" class="form__label">Image</label>
                    <div class="flex g1">
                        <div class="form__field--input">
                            <input
                                :value="src.fullRelativeUrl"
                                type="text"
                                name="image"
                                value="{$item.image | htmlent}"
                                class="br1"
                                readonly
                            />                  
                        </div>
                        <button
                            x-ref="imageselect"
                            @click="
                                MODx.load({
                                    xtype: 'modx-browser',
                                    id: Ext.id(),
                                    multiple: true,
                                    listeners: {
                                        select: (img) => {
                                            console.log(img);
                                            src = img;
                                        }
                                    },
                                    source: 1,
                                    openTo: '/'
                                }).show();
                            "
                            type="button"
                            id="selectimage"
                            class="x-btn primary-button b"
                        >select</button>
                    </div>
                    <template x-if="src">
                        <img
                            :src="src.image"
                            class="db w-50 mt1 aspect-ratio--16x9"
                        />
                    </template>
                </div>

                <button type="submit" class="x-btn primary-button b">Submit</button>

            </form>
        
        </div>

    </div>

</div>