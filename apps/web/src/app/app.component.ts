import {Component} from '@angular/core';
import {Meta, Title} from '@angular/platform-browser';

@Component({
    selector: 'jf-portfolio',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss']
})
export class AppComponent {
    constructor(
        private readonly title: Title,
        private readonly meta: Meta
    ) {
        this.title.setTitle('Jay Fialkowski Consulting');
        this.meta.addTags([
            {name: 'description', content: 'Jay Fialkowski consulting portfolio'},
            {name: 'author', content: 'Jay Fialkowski'},
            {
                name: 'keywords',
                content: 'angular consulting front end web develop jay fialkowski cap tech captech resume'
            }
        ]);
    }
}
