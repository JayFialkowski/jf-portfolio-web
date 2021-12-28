import {Component} from '@angular/core';

@Component({
    templateUrl: './resume.component.html',
    styleUrls: ['./resume.component.scss']
})

export class ResumeComponent {

    readonly links = [
        {
            icon: 'phone-fill',
            label: '(716) 866-2199',
            href: 'tel:7168662199'
        },
        {
            icon: 'envelope-fill',
            label: 'jayfialkowski@me.com',
            href: 'mailto:jayfialkowski@me.com'
        },
        {
            icon: 'github',
            label: 'www.github.com/JayFialkowski',
            href: 'https://github.com/jayfialkowski'
        },
        {
            icon: 'linkedin',
            label: 'www.linkedin.com/in/jayfialkowski',
            href: 'https://linkedin.com/in/jayfialkowski'
        }
    ];

    readonly phone = '(716) 866-2199';
    readonly email = 'jayfialkowski@me.com';
    readonly github = 'www.github.com/JayFialkowski';
    readonly linkedin = 'www.linkedin.com/in/jayfialkowski';
}
