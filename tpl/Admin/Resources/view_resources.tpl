{include file='globalheader.tpl' DataTable=true}

<div id="page-manage-resources" class="admin-page">
    <div class="clearfix border-bottom mb-3">
        <h1 class="float-start">{translate key='ManageResources'}</h1>
    </div>

    <div class="accordion">
        <div class="accordion-item shadow mb-3 panel-default filterTable" id="filter-resources-panel">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed link-primary fw-bold" type="button" data-bs-toggle="collapse"
                    data-bs-target="#filter-resources-content" aria-expanded="false"
                    aria-controls="filter-resources-content">
                    <i class="bi bi-funnel-fill me-1"></i>{translate key="Filter"}
                </button>
            </h2>
            <div id="filter-resources-content" class="accordion-collapse collapse">
                <form id="filterForm" class="horizontal-list" role="form" method="get">
                    <div class="accordion-body">
                        <div class="row gy-2 mb-2">
                            {assign var=groupClass value="col-12 col-sm-4 col-md-3"}

                            <div class="form-group {$groupClass}">
                                <label for="filterResourceName" class="fw-bold">{translate key=Resource}</label>
                                <input type="search" id="filterResourceName" class="form-control"
                                    {formname key=RESOURCE_NAME} value="{$ResourceNameFilter}"
                                    placeholder="{translate key=Name}" />
                                {*<span class="searchclear glyphicon glyphicon-remove-circle" ref="filterResourceName"></span>*}
                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="filterScheduleId" class="fw-bold">{translate key=Schedule}</label>
                                <select id="filterScheduleId" {formname key=SCHEDULE_ID} class="form-select">
                                    <option value="">{translate key=AllSchedules}</option>
                                    {object_html_options options=$AllSchedules key='GetId' label="GetName" selected=$ScheduleIdFilter}
                                </select>
                            </div>

                            <div class="form-group {$groupClass}">
                                <label for="filterResourceType" class="fw-bold">{translate key=ResourceType}</label>
                                <select id="filterResourceType" class="form-select" {formname key=RESOURCE_TYPE_ID}>
                                    <option value="">{translate key=AllResourceTypes}</option>
                                    {object_html_options options=$ResourceTypes key='Id' label="Name" selected=$ResourceTypeFilter}
                                </select>
                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="resourceStatusIdFilter"
                                    class="fw-bold">{translate key=ResourceStatus}</label>
                                <select id="resourceStatusIdFilter" class="form-select"
                                    {formname key=RESOURCE_STATUS_ID}>
                                    <option value="">{translate key=AllResourceStatuses}</option>
                                    <option value="{ResourceStatus::AVAILABLE}">{translate key=Available}</option>
                                    <option value="{ResourceStatus::UNAVAILABLE}">{translate key=Unavailable}
                                    </option>
                                </select>
                                {*<label for="resourceReasonIdFilter"
                                        class="visually-hidden">{translate key=Reason}</label>
                                    <select id="resourceReasonIdFilter" class="form-select w-auto"
                                        {formname key=RESOURCE_STATUS_REASON_ID}>
                                        <option value="">-</option>
                                    </select>*}

                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="filterCapacity" class="fw-bold">{translate key=MinimumCapacity}</label>
                                <input type="number" min="0" id="filterCapacity" class="form-control"
                                    {formname key=MAX_PARTICIPANTS} value="{$CapacityFilter}"
                                    placeholder="{translate key=MinimumCapacity}" />
                                {*<span class="searchclear glyphicon glyphicon-remove-circle"
                                        ref="filterCapacity"></span>*}
                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="filterRequiresApproval"
                                    class="fw-bold">{translate key=ResourceRequiresApproval}</label>
                                <select id="filterRequiresApproval" class="form-select" {formname key=REQUIRES_APPROVAL}
                                    title="{translate key='ResourceRequiresApproval'}">
                                    <option value="">{translate key='ResourceRequiresApproval'}</option>
                                    {html_options options=$YesNoOptions selected=$RequiresApprovalFilter}
                                </select>
                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="filterAutoAssign"
                                    class="fw-bold">{translate key=ResourcePermissionAutoGranted}</label>
                                <select id="filterAutoAssign" class="form-select" {formname key=AUTO_ASSIGN}
                                    title="{translate key='ResourcePermissionAutoGranted'}">
                                    <option value="">{translate key='ResourcePermissionAutoGranted'}</option>
                                    {html_options options=$YesNoOptions selected=$AutoPermissionFilter}
                                </select>
                            </div>
                            <div class="form-group {$groupClass}">
                                <label for="filterAllowMultiDay"
                                    class="fw-bold">{translate key=ResourceAllowMultiDay}</label>
                                <select id="filterAllowMultiDay" class="form-select" {formname key=ALLOW_MULTIDAY}
                                    title="{translate key=ResourceAllowMultiDay}">
                                    <option value="">{translate key=ResourceAllowMultiDay}</option>
                                    {html_options options=$YesNoOptions selected=$AllowMultiDayFilter}
                                </select>
                            </div>
                            <div class="clearfix mb-3">
                                {foreach from=$AttributeFilters item=attribute}
                                    {control type="AttributeControl" idPrefix="search" attribute=$attribute searchmode=true class="customAttribute filter-customAttribute{$attribute->Id()}
                                {$groupClass}"}
                                {/foreach}
                            </div>
                        </div>
                        <div class="card-footer border-top pt-3">
                            {filter_button id="filter" class="btn-sm"}
                            {reset_button id="clearFilter" class="btn-sm"}
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    {*pagination pageInfo=$PageInfo showCount=true*}

    <div id="globalError" class="error d-none"></div>

    {if !empty($Resources)}
        <div class="card shadow panel-default admin-panel" id="list-resources-panel">
            <div class="card-body accordion" id="resourceList">
                {assign var=tableId value=resourcesTable}
                <table class="table table-borderless w-100" id="{$tableId}">
                    <thead class="d-none">
                        <tr>
                            <th>{translate key="Resources"}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$Resources item=resource}
                            {assign var=id value=$resource->GetResourceId()}
                            <tr>
                                <td>
                                    <div class="accordion-item shadow mb-2">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                data-bs-target="#id{$resource->GetResourceId()}" aria-expanded="false"
                                                aria-controls="id{$resource->GetResourceId()}">
                                                {$resource->GetName()}
                                            </button>
                                        </h2>
                                        <div id="id{$id}" class="accordion-collapse collapse">
                                            <div class="accordion-body resourceDetails row" data-resourceId="{$id}">
                                                <div class="col-12 col-sm-5">
                                                    <input type="hidden" class="id" value="{$id}" />
                                                    <div class="row gy-2">
                                                        <div class="col-sm-3 col-6 resourceImage">
                                                            <div class="">
                                                                {if $resource->HasImage()}

                                                                    <div id="resourceImageCarousel" class="carousel slide">
                                                                        <div class="carousel-inner">
                                                                            <div class="carousel-item active">
                                                                                <img src="{resource_image image=$resource->GetImage()}"
                                                                                    alt="{$resource->GetName()}"
                                                                                    class="rounded d-block w-100" />
                                                                            </div>
                                                                            {foreach from=$resource->GetImages() item=image}
                                                                                <div class="carousel-item">
                                                                                    <img src="{resource_image image=$image}"
                                                                                        alt="{$resource->GetName()}"
                                                                                        class="rounded d-block w-100" />
                                                                                </div>
                                                                            {/foreach}
                                                                        </div>

                                                                        <div class="carousel-indicators">
                                                                            {if $resource->GetImages()|count > 0}
                                                                                {assign var=slide value=1}
                                                                                <button type="button"
                                                                                    data-bs-target="#resourceImageCarousel"
                                                                                    data-bs-slide-to="0" class="active"></button>
                                                                                {foreach from=$resource->GetImages() item=image}
                                                                                    <button type="button"
                                                                                        data-bs-target="#resourceImageCarousel"
                                                                                        data-bs-slide-to="{$slide}"></button>
                                                                                    {assign var=slide value=$slide+1}
                                                                                {/foreach}
                                                                            {/if}
                                                                        </div>
                                                                    </div>
                                                                {else}
                                                                    <div class="text-center">
                                                                        <div
                                                                            class="noImage w-100 bg-light border rounded-3 mx-auto">
                                                                            <span class="bi bi-image fs-1"></span>
                                                                        </div>
                                                                    </div>
                                                                {/if}
                                                            </div>
                                                            <div class="text-center mt-4">
                                                                {translate key=ResourceColor}
                                                                <div class="border rounded-1 mx-auto w-100"
                                                                    style="height: 23px;background-color:{if $resource->HasColor()}{$resource->GetColor()}{else}#ffffff{/if}">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-9 col-6">
                                                            <div class="title resourceName fs-5 fw-bold">
                                                                {$resource->GetName()}</div>
                                                            <div>
                                                                {translate key='Status'}
                                                                {if $resource->IsAvailable()}
                                                                    <span class="fw-bold">{translate key='Available'}<i
                                                                            class="bi bi-check-circle-fill text-success ms-1"></i></span>
                                                                {elseif $resource->IsUnavailable()}
                                                                    <span class="fw-bold">{translate key='Unavailable'}<i
                                                                            class="bi bi-exclamation-circle-fill text-warning ms-1"></i></span>
                                                                {else}
                                                                    <span class="fw-bold">{translate key='Hidden'}<i
                                                                            class="bi bi-x-circle-fill text-danger ms-1"></i></span>
                                                                {/if}
                                                                {if array_key_exists($resource->GetStatusReasonId(),$StatusReasons)}
                                                                    <span
                                                                        class="statusReason">{$StatusReasons[$resource->GetStatusReasonId()]->Description()}</span>
                                                                {/if}
                                                            </div>

                                                            <div>
                                                                {translate key='Schedule'}
                                                                <span
                                                                    class="fw-bold">{$Schedules[$resource->GetScheduleId()]->GetName()}</span>
                                                            </div>

                                                            <div>
                                                                {translate key='ResourceType'}
                                                                <span class="fw-bold">
                                                                    {if $resource->HasResourceType()}
                                                                        {$ResourceTypes[$resource->GetResourceTypeId()]->Name()}
                                                                    {else}
                                                                        {translate key='NoResourceTypeLabel'}
                                                                    {/if}
                                                                </span>
                                                            </div>
                                                            <div>
                                                                {translate key=SortOrder}
                                                                <span class="fw-bold">
                                                                    {$resource->GetSortOrder()|default:"0"}
                                                                </span>
                                                            </div>
                                                            <div>
                                                                {translate key='Location'}
                                                                <span class="fw-bold">
                                                                    {if $resource->HasLocation()}
                                                                        {$resource->GetLocation()}
                                                                    {else}
                                                                        {translate key='NoLocationLabel'}
                                                                    {/if}
                                                                </span>
                                                            </div>
                                                            <div>
                                                                {translate key='Contact'}
                                                                <span class="fw-bold">
                                                                    {if $resource->HasContact()}
                                                                        {$resource->GetContact()}
                                                                    {else}
                                                                        {translate key='NoContactLabel'}
                                                                    {/if}
                                                                </span>
                                                            </div>
                                                            <div>
                                                                {translate key='Description'}
                                                                {if $resource->HasDescription()}
                                                                    {assign var=description value=$resource->GetDescription()}
                                                                {else}
                                                                    {assign var=description value=''}
                                                                {/if}
                                                                {strip}
                                                                    <div>
                                                                        {if $resource->HasDescription()}
                                                                            {$description}
                                                                        {else}
                                                                            {translate key='NoDescriptionLabel'}
                                                                        {/if}
                                                                    </div>
                                                                {/strip}
                                                            </div>
                                                            <div>
                                                                {translate key='Notes'}
                                                                <div>
                                                                    {if $resource->HasNotes()}
                                                                        {$resource->GetNotes()}
                                                                    {else}
                                                                        {translate key='NoNotesLabel'}
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                            <div>
                                                                {translate key='ResourceAdministrator'}
                                                                <span
                                                                    class="fw-bold">{$ResourceAdminGroup[$resource->GetAdminGroupId()]->Name}</span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="col-12 col-sm-7">
                                                    <div class="row">
                                                        <div class="col-sm-6 col-12">
                                                            <div class="mb-4">
                                                                <span class="fs-6 fw-bold">{translate key=Duration}</span>
                                                                <div class="durationPlaceHolder">
                                                                    {include file="Admin/Resources/manage_resources_duration.tpl" resource=$resource}
                                                                </div>
                                                            </div>

                                                            {if $CreditsEnabled}
                                                                <div class="mb-4">
                                                                    <span class="fs-6 fw-bold">{translate key='Credits'}</span>
                                                                    <div class="creditsPlaceHolder">
                                                                        {include file="Admin/Resources/manage_resources_credits.tpl" resource=$resource}
                                                                    </div>
                                                                </div>
                                                            {/if}

                                                            <div style="mb-4">
                                                                <span class="fs-6 fw-bold">{translate key='Capacity'}</span>
                                                                <div class="capacityPlaceHolder">
                                                                    {include file="Admin/Resources/manage_resources_capacity.tpl" resource=$resource}
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="col-sm-6 col-12">
                                                            <div style="mb-4">
                                                                <span class="fs-6 fw-bold">{translate key=Access}</span>
                                                                <div class="accessPlaceHolder">
                                                                    {include file="Admin/Resources/manage_resources_access.tpl" resource=$resource}
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6 col-12 mt-4">
                                                            <span class="fs-6 fw-bold">{translate key='PermissionType'}</span>
                                                            <div class="resourcePermissionTypePlaceHolder">
                                                                {if $ResourcePermissionTypes[$resource->GetId()] == 0}
                                                                    {translate key=FullAccess}
                                                                {else}
                                                                    {translate key=ViewOnly}
                                                                {/if}
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6 col-12 mt-4">
                                                            <span class="fs-6 fw-bold">{translate key='ResourceGroups'}</span>
                                                            <div class="resourceGroupsPlaceHolder">
                                                                {if $resource->GetResourceGroupIds()|default:array()|count == 0}
                                                                    {translate key=None}
                                                                {/if}
                                                                {foreach from=$resource->GetResourceGroupIds() item=resourceGroupId name=eachGroup}
                                                                    <span class="resourceGroupId"
                                                                        data-value="{$resourceGroupId}">{$ResourceGroup[$resourceGroupId]->name}</span>{if !$smarty.foreach.eachGroup.last},
                                                                    {/if}
                                                                {/foreach}
                                                            </div>
                                                        </div>

                                                        <div class="col-12 mt-2">
                                                            <div class="fs-6 fw-bold">{translate key='Public'}</div>
                                                            <div class="publicSettingsPlaceHolder">
                                                                {include file="Admin/Resources/manage_resources_public.tpl" resource=$resource modeEdit=true}
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="customAttributes">
                                                    {if $AttributeList|default:array()|count > 0}
                                                        {foreach from=$AttributeList item=attribute}
                                                            {include file='Admin/InlineAttributeEdit.tpl' id=$id attribute=$attribute value=$resource->GetAttributeValue($attribute->Id())}
                                                        {/foreach}
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        <h3 class="text-center">{translate key='NoResourcesToView'}</h3>
    {/if}

    {csrf_token}

    {include file="javascript-includes.tpl" DataTable=true}
    {datatable tableId=$tableId}
    {jsfile src="ajax-helpers.js"}
    {jsfile src="admin/schedule.js"}
    {jsfile src="js/jquery.form-3.09.min.js"}
</div>

{*pagination pageInfo=$PageInfo showCount=true*}

{include file='globalfooter.tpl'}